library scheduler_react.app_component;

import 'package:react/react_client.dart';
import 'package:scheduler/scheduler.dart';
import 'package:w_flux/w_flux.dart';

import 'package:scheduler_react/day_component.dart';
import 'package:over_react/over_react.dart';

@Factory()
UiFactory<AppProps> App;

@Props()
class AppProps extends FluxUiProps<AppActions, AppStore> {}

@Component()
class AppComponent extends FluxUiComponent<AppProps> {
  @override
  void componentWillMount() {
    super.componentWillMount();
    props.actions.updateDays();
  }

  @override
  ReactElement render() {
    var dayComponents = props.store.days
        .map((day) => (DayFactory()
          ..className = day.dayName
          ..key = _toDateId(day)
          ..actions = props.store.getDayActions(_toDateId(day))
          ..store = props.store.getDayStore(_toDateId(day)))())
        .toList();

    return (Dom.div()..id = 'schedule')([
      (Dom.i()
        ..className = 'fa fa-arrow-circle-left'
        ..key = 'left'
        ..onClick = (_) => props.actions.move(-1))(),
      (Dom.section()..key = 'days')(dayComponents),
      (Dom.i()
        ..className = 'fa fa-arrow-circle-right'
        ..key = 'right'
        ..onClick = (_) => props.actions.move(1))()
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

  AppActions _appActions;

  AppStore(this._appActions, this._schedulerService) {
    _appActions.updateDays.listen((_) async {
      var days = await _schedulerService.getRbtvDays(
          _startHour, _startMinute, _dayOffset);
      _schedulerService.optimizeHeights(days, 15);
      days.forEach((day) {
        var actions = new DayActions();
        var dateId = dateIdFormat.format(day.date);
        _dayStores.putIfAbsent(dateId, () => new DayStore(day));
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

  List<Day> get days => _days;

  DayStore getDayStore(String dateId) => _dayStores[dateId];
  DayActions getDayActions(String dateId) => _dayActions[dateId];
}
