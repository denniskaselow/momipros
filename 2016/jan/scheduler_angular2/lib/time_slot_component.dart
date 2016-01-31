library scheduler_angular2.time_slot_component;

import 'package:angular2/angular2.dart';
import 'package:scheduler/scheduler.dart';

@Component(
    selector: 'schedule-time-slot',
    template: '''
<div class='time'>{{ timeSlot.startLabel }}</div>
<div class='name'>{{timeSlot.name}}</div>
<div class='duration'>{{timeSlot.durationLabel}}</div>
''',
    styles: const [
      '''
:host {
  display: flex;
  justify-content: space-between;
  position: relative;
  outline: 1px solid black;
  overflow: hidden;
}
.time {
  min-width: 40px;
  text-align: center;
}
.name {
  font-weight: bold;
  margin-left: 5px;
  flex-grow: 1;
}
.duration {
  align-self: flex-end;
  font-size: 12px;
  min-width: 40px;
  text-align: right;
}
'''
    ])
class TimeSlotComponent {
  @Input() TimeSlot timeSlot;
}
