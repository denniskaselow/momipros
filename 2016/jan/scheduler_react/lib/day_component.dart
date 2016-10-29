library scheduler_angular2.app_component;

import 'package:over_react/over_react.dart';
import 'package:w_flux/w_flux.dart';
import 'package:scheduler_react/time_slot_component.dart';
import 'package:scheduler/scheduler.dart';

@Factory()
UiFactory<DayProps> DayFactory;

@Props()
class DayProps extends FluxUiProps<DayActions, DayStore> {}

@Component()
class DayComponent extends FluxUiComponent<DayProps> {
  @override
  dynamic render() {
    var timeSlotComponents = props.store.day.timeSlots
        .map((timeSlot) => (TimeSlotComponentFactory()
          ..actions = props.store.getTimeSlotActions(_toTimeId(timeSlot))
          ..store = props.store.getTimeSlotStore(_toTimeId(timeSlot))
          ..key = _toTimeId(timeSlot))())
        .toList();

    return (Dom.div()
      ..className =
          'day ${props.className} ${props.store.day.isToday ? 'today' : ''}')([
      (Dom.h2()..key = 'dayName')([props.store.day.label]),
      (Dom.div()
        ..className = 'shows'
        ..key = 'show')(Dom.section()(timeSlotComponents))
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
