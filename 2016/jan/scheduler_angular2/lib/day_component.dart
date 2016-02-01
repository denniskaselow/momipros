library scheduler_angular2.app_component;

import 'package:angular2/angular2.dart';
import 'package:scheduler_angular2/time_slot_component.dart';

import 'package:scheduler/scheduler.dart';

@Component(
    selector: 'schedule-day',
    template: '''
<h2>{{ day.label }}</h2>
<schedule-time-slot
          *ngFor="#timeSlot of day.timeSlots"
          [timeSlot]="timeSlot"
          [style.height.px]='timeSlot.height'>
</schedule-time-slot>
    ''',
    styles: const [
      '''
:host {
  margin: 0px 5px 0px 5px;
  flex-basis: 0;
  flex-grow: 1;
  min-width: 180px;
}
h2 {
  text-align: center;
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