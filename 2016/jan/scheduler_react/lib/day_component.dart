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
      'className': 'day ${props['className']} ${store.day.isToday ? 'today' : ''}'
    }, [
      h2({'key': 'dayName'}, [store.day.label]),
      div({'className': 'shows', 'key': 'show'}, section({}, timeSlotComponents))
    ]);
  }

  String _toTimeId(TimeSlot timeSlot) => timeIdFormat.format(timeSlot.start);
}

class DayActions {}

class DayStore extends Store {
  Map<String, TimeSlotStore> _timeSlotStores = {};
  Map<String, TimeSlotActions> _timeSlotActions = {};

  Day _day;
  String _dayId;

  DayStore(this._day) {
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

  TimeSlotStore getTimeSlotStore(String timeSlotId) =>
      _timeSlotStores[timeSlotId];
  TimeSlotActions getTimeSlotActions(String timeSlotId) =>
      _timeSlotActions[timeSlotId];
}
