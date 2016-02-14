library scheduler_react.app_component;

import 'package:w_flux/w_flux.dart';
import 'package:react/react.dart';

import 'package:scheduler/scheduler.dart';
import 'package:scheduler_react/day_component.dart';

final appComponent = registerComponent(() => new _AppComponent());

class _AppComponent extends FluxComponent<AppActions, AppStore> {
  componentWillMount() {
    super.componentWillMount();
    actions.updateDays();
  }

  @override
  render() {
    var dayComponents = store.days
        .map((day) => dayComponent({
              'className': day.dayName,
              'key': _toDateId(day),
              'actions': store.getDayActions(_toDateId(day)),
              'store': store.getDayStore(_toDateId(day))
            }))
        .toList();

    return div({
      'id': 'schedule'
    }, [
      i({
        'className': 'fa fa-arrow-circle-left',
        'key': 'left',
        'onClick': (_) => actions.move(-1)
      }),
      dayComponents,
      i({
        'className': 'fa fa-arrow-circle-right',
        'key': 'right',
        'onClick': (_) => actions.move(1)
      })
    ]);
  }

  String _toDateId(Day day) => dateIdFormat.format(day.date);
}

class AppActions {
  final Action updateDays = new Action();
  final Action<int> move = new Action<int>();
}

class AppStore extends Store {
  Map<String, DayStore> _dayStores = {};
  Map<String, DayActions> _dayActions = {};

  RbtvSchedulerService _schedulerService;
  int _startHour = 10;
  int _startMinute = 30;
  int _dayOffset = 0;
  List<Day> _days = [];

  List<Day> get days => _days;

  AppActions _appActions;

  AppStore(this._appActions, this._schedulerService) {
    _appActions.updateDays.listen((_) async {
      var days = await _schedulerService.getRbtvDays(
          _startHour, _startMinute, _dayOffset);
      _schedulerService.optimizeHeights(days, 15);
      days.forEach((day) {
        var actions = new DayActions();
        var dateId = dateIdFormat.format(day.date);
        _dayStores.putIfAbsent(dateId, () => new DayStore(actions, day));
        _dayActions.putIfAbsent(dateId, () => actions);
      });
      _days = days;
      trigger();
    });
    _appActions.move.listen((direction) {
      _dayOffset += direction;
      _appActions.updateDays();
    });
  }

  DayStore getDayStore(String dateId) => _dayStores[dateId];
  DayActions getDayActions(String dateId) => _dayActions[dateId];
}
