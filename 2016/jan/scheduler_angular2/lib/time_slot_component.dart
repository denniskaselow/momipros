library scheduler_angular2.time_slot_component;

import 'package:angular2/angular2.dart';
import 'package:scheduler/scheduler.dart';
import 'dart:html';
import 'dart:async';

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
<div class='progress' [style.width]='0'></div>
''',
    host: const {
      '(mouseenter)': r'expand($event.target)',
      '(mouseleave)': r'shrink($event.target)'
    },
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
.progress {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: hsla(0, 0%, 75%, 0.2);
}
.content {
  font-weight: bold;
  margin-left: 5px;
  flex-grow: 1;
  display: flex;
  flex-direction: column;
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
class TimeSlotComponent implements AfterViewInit {
  @Input()
  TimeSlot timeSlot;
  ElementRef element;

  TimeSlotComponent(this.element);

  @override
  void ngAfterViewInit() {
    var progressStyle = ((element.nativeElement as HtmlElement)
            .querySelector('.progress') as HtmlElement)
        .style;
    var progress = getProgress();
    progressStyle.width = '$progress%';
    new Timer.periodic(new Duration(minutes: 1), (Timer timer) {
      var progress = getProgress();
      if (progress >= 100.0) {
        timer.cancel();
      }
      progressStyle.width = '$progress%';
    });
  }

  void expand(HtmlElement target) {}
  void shrink(HtmlElement target) {}

  double getProgress() {
    var timepassed = new DateTime.now().difference(timeSlot.start);
    if (timepassed.inMinutes <= 0) {
      return 0.0;
    }
    var duration = timeSlot.getDuration();
    if (timepassed.inMinutes > duration.inMinutes) {
      return 100.0;
    }
    return 100.0 * timepassed.inMinutes / duration.inMinutes;
  }
}
