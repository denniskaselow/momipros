library scheduler_angular2.app_component;

import 'package:angular2/angular2.dart';
import 'package:scheduler_angular2/time_slot_component.dart';

import 'package:scheduler/scheduler.dart';

@Component(
    selector: 'schedule-day',
    template: '''
<div [ngClass]='day.dayName' [class.today]='isToday'>
  <h2>{{ day.label }}</h2>
  <div class="shows">
    <schedule-time-slot
              *ngFor="#timeSlot of day.timeSlots"
              [timeSlot]="timeSlot"
              [style.flex-grow]='timeSlot.height'
              [class.current]='isCurrent(timeSlot)'>
    </schedule-time-slot>
  </div>
</div>
    ''',
    styles: const [
      '''
:host {
  flex-basis: 0;
  flex-grow: 1;
  min-width: 180px;
}
:host > div {
  display: flex;
  flex-direction: column;
  height: 100vh;
}
.Mon {
  background-color: hsla(0, 30%, 60%, 0.5);
}
.Mon schedule-time-slot:nth-child(2n) {
  background-color: hsla(0, 20%, 70%, 0.5);
}
.Tue {
  background-color: hsla(50, 30%, 60%, 0.5);
}
.Tue schedule-time-slot:nth-child(2n) {
  background-color: hsla(50, 20%, 70%, 0.5);
}
.Wed {
  background-color: hsla(100, 30%, 60%, 0.5);
}
.Wed schedule-time-slot:nth-child(2n) {
  background-color: hsla(100, 20%, 70%, 0.5);
}
.Thu {
  background-color: hsla(150, 30%, 60%, 0.5);
}
.Thu schedule-time-slot:nth-child(2n) {
  background-color: hsla(150, 20%, 70%, 0.5);
}
.Fri {
  background-color: hsla(200, 30%, 60%, 0.5);
}
.Fri schedule-time-slot:nth-child(2n) {
  background-color: hsla(200, 20%, 70%, 0.5);
}
.Sat {
  background-color: hsla(250, 30%, 60%, 0.5);
}
.Sat schedule-time-slot:nth-child(2n) {
  background-color: hsla(250, 20%, 70%, 0.5);
}
.Sun {
  background-color: hsla(300, 30%, 60%, 0.5);
}
.Sun schedule-time-slot:nth-child(2n) {
  background-color: hsla(300, 20%, 70%, 0.5);
}
h2 {
  text-align: center;
  font-size: 16px;
  flex-grow: 0;
  margin: 0;
  padding: 7px 0 2px 0;
  background-color: hsla(0, 0%, 50%, 0.3);
}
.shows {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
}
schedule-time-slot {
  flex-basis: 0;
}
schedule-time-slot.current {
  outline: 2px ridge #C2185B;
  outline-offset: -1px;
}
.today {
  outline: 2px ridge #C2185B;
  outline-offset: -2px;
}
'''
    ],
    directives: const [
      TimeSlotComponent,
      NgFor,
      NgIf,
      NgClass
    ])
class DayComponent {
  @Input() Day day;
  DateTime currentDate = new DateTime.now();

  bool get isToday =>
      currentDate.year == day.date.year &&
      currentDate.month == day.date.month &&
      currentDate.day == day.date.day;

  bool isCurrent(TimeSlot slot) =>
      isToday &&
      slot.start.isBefore(currentDate) &&
      slot.end.isAfter(currentDate);
}
