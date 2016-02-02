library scheduler_angular2.time_slot_component;

import 'package:angular2/angular2.dart';
import 'package:scheduler/scheduler.dart';

@Component(
    selector: 'schedule-time-slot',
    template: '''
<div class='time'>{{ timeSlot.getStartLabel() }}</div>
<div class='content'>
  <div class='name'>
    {{ timeSlot.name }}
  </div>
  <div class='description'>
    {{ timeSlot.description }}
  </div>
</div>
<div class='duration'>{{ timeSlot.getDurationLabel() }}</div>
''',
    styles: const [
      '''
:host {
  display: flex;
  justify-content: space-between;
  position: relative;
  overflow: hidden;
  font-size: 14px;
  padding: 0px 5px 0px 5px;
  margin-top: 2px;
}
.time {
  min-width: 40px;
  text-align: center;
}
.content {
  font-weight: bold;
  margin-left: 5px;
  flex-grow: 1;
  display: flex;
  flex-direction: column;
}
.content > .name {
  min-height: 20px;
}
.content > .description {
  font-weight: normal;
  font-size: 12px;
}
.duration {
  align-self: flex-end;
  font-size: 12px;
  min-width: 40px;
  text-align: right;
  min-height: 20px;
}
'''
    ])
class TimeSlotComponent {
  @Input() TimeSlot timeSlot;
}
