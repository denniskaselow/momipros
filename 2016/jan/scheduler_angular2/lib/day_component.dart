library scheduler_angular2.app_component;

import 'package:angular2/angular2.dart';
import 'package:scheduler_angular2/time_slot_component.dart';

import 'package:scheduler/scheduler.dart';

@Component(
    selector: 'schedule-day',
    template: '''
<h2>{{ day.label }}</h2>
<div class="shows">
  <schedule-time-slot
            *ngFor="#timeSlot of day.timeSlots"
            [timeSlot]="timeSlot"
            [style.flex-grow]='timeSlot.height'>
  </schedule-time-slot>
</div>
    ''',
    styles: const [
      '''
:host {
  margin: 0px 2px 0px 2px;
  flex-basis: 0;
  flex-grow: 1;
  min-width: 180px;
  display: flex;
  flex-direction: column;
  height: 100vh;
}
h2 {
  text-align: center;
  font-size: 16px;
  flex-grow: 0;
  margin: 5px 0 5px 0;
}
.shows {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
}
schedule-time-slot {
  flex-basis: 0;
}
'''
    ],
    directives: const [
      TimeSlotComponent,
      NgFor,
      NgIf
    ])
class DayComponent {
  @Input() Day day;
}
