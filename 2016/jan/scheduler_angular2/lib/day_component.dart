library scheduler_angular2.app_component;

import 'dart:html';

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
    host: const {
      '(mouseenter)': r'expand($event.target)',
      '(mouseleave)': r'shrink($event.target)'
    },
    styles: const [
      '''
:host {
  flex-basis: 0;
  flex-grow: 1;
  min-width: 180px;
  transition: flex-grow 0.25s cubic-bezier(.7, .25, .25, .7);
}
:host.today {
  flex-grow: 1.5;
}
:host {
  display: flex;
  flex-direction: column;
  height: 100vh;
}
:host.Mon {
  background-color: hsla(0, 30%, 60%, 0.5);
}
:host.Mon schedule-time-slot:nth-child(2n) {
  background-color: hsla(0, 20%, 70%, 0.5);
}
:host.Tue {
  background-color: hsla(50, 30%, 60%, 0.5);
}
:host.Tue schedule-time-slot:nth-child(2n) {
  background-color: hsla(50, 20%, 70%, 0.5);
}
:host.Wed {
  background-color: hsla(100, 30%, 60%, 0.5);
}
:host.Wed schedule-time-slot:nth-child(2n) {
  background-color: hsla(100, 20%, 70%, 0.5);
}
:host.Thu {
  background-color: hsla(150, 30%, 60%, 0.5);
}
:host.Thu schedule-time-slot:nth-child(2n) {
  background-color: hsla(150, 20%, 70%, 0.5);
}
:host.Fri {
  background-color: hsla(200, 30%, 60%, 0.5);
}
:host.Fri schedule-time-slot:nth-child(2n) {
  background-color: hsla(200, 20%, 70%, 0.5);
}
:host.Sat {
  background-color: hsla(250, 30%, 60%, 0.5);
}
:host.Sat schedule-time-slot:nth-child(2n) {
  background-color: hsla(250, 20%, 70%, 0.5);
}
:host.Sun {
  background-color: hsla(300, 30%, 60%, 0.5);
}
:host.Sun schedule-time-slot:nth-child(2n) {
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
'''
    ],
    directives: const [
      TimeSlotComponent,
      NgFor,
      NgIf
    ])
class DayComponent {
  @Input()
  Day day;

  void expand(HtmlElement target) {
    if (target.classes.contains('today')) {
      target.style.flexGrow = '2';
    } else {
      target.style.flexGrow = '1.5';
    }
  }

  void shrink(HtmlElement target) {
    if (target.classes.contains('today')) {
      target.style.flexGrow = '1.5';
    } else {
      target.style.flexGrow = '1';
    }
  }
}
