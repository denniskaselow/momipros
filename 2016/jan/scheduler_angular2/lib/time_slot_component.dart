library scheduler_angular2.time_slot_component;

import 'package:angular2/angular2.dart';
import 'package:scheduler/scheduler.dart';

@Component(
    selector: 'schedule-time-slot',
    template: '''
<div>{{ timeSlot.startLabel }}<br/>({{timeSlot.durationLabel}})</div>
<div class='name'>{{timeSlot.name}}</div>
''',
    styles: const [
      '''
:host {
  display: flex;
}
:host > .name {
    font-weight: bold;
}
'''
    ])
class TimeSlotComponent {
  @Input() TimeSlot timeSlot;
}
