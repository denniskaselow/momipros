library scheduler_angular2.app_component;

import 'package:w_flux/w_flux.dart';
import 'package:react/react.dart';
import 'package:scheduler_react/time_slot_component.dart';
import 'package:scheduler/scheduler.dart';

final dayComponent = registerComponent(() => new _DayComponent());

class _DayComponent extends FluxComponent<DayActions, DayStore> {
  @override
  dynamic render() {
    var timeSlotComponents = store.day.timeSlots
        .map((timeSlot) => timeSlotComponent({
              'actions': store.getTimeSlotActions(_toTimeId(timeSlot)),
              'store': store.getTimeSlotStore(_toTimeId(timeSlot)),
              'key': _toTimeId(timeSlot)
            }))
        .toList();

    return div({
      'className': 'day ${props['className']}',
      'style': {'flexGrow': store.width},
      'onMouseEnter': actions.expand,
      'onMouseLeave': actions.shrink
    }, [
      h2({'key': 'dayName'}, [store.day.label]),
      div({'className': 'shows', 'key': 'show'}, section({}, timeSlotComponents))
    ]);
  }

  String _toTimeId(TimeSlot timeSlot) => timeIdFormat.format(timeSlot.start);
}

class DayActions {
  Action expand = new Action();
  Action shrink = new Action();
}

class DayStore extends Store {
  Map<String, TimeSlotStore> _timeSlotStores = {};
  Map<String, TimeSlotActions> _timeSlotActions = {};

  Day _day;
  String _dayId;
  double _width;

  DayActions _dayActions;

  DayStore(this._dayActions, this._day) {
    triggerOnAction(_dayActions.expand, (_) => _width += 0.5);
    triggerOnAction(_dayActions.shrink, (_) => _width -= 0.5);
    _width = day.isToday ? 1.5 : 1.0;
    _dayId = dateIdFormat.format(day.date);
    _day.timeSlots.forEach((timeSlot) {
      var actions = new TimeSlotActions();
      _timeSlotActions.putIfAbsent(
          timeIdFormat.format(timeSlot.start), () => actions);
      _timeSlotStores.putIfAbsent(timeIdFormat.format(timeSlot.start),
          () => new TimeSlotStore(actions, timeSlot));
    });
  }

  Day get day => _day;
  String get dayId => _dayId;
  double get width => _width;

  TimeSlotStore getTimeSlotStore(String timeSlotId) =>
      _timeSlotStores[timeSlotId];
  TimeSlotActions getTimeSlotActions(String timeSlotId) =>
      _timeSlotActions[timeSlotId];
}
