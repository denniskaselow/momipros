library scheduler_angular2.time_slot_component;

import 'package:angular2/angular2.dart';
import 'package:scheduler/scheduler.dart';
import 'dart:html';
import 'dart:async';

@Component(
    selector: 'schedule-time-slot',
    template: '''
<div class='time' [class.live]='timeSlot.live' [class.premiere]='timeSlot.premiere'>{{ timeSlot.getStartLabel() }}</div>
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
    styles: const [
      '''
:host {
  display: flex;
  justify-content: space-between;
  position: relative;
  overflow: hidden;
  font-size: 14px;
  padding: 0px 5px 0px 2px;
  flex-basis: 0;
}
:host.current {
  outline: 2px ridge #C2185B;
  outline-offset: -1px;
}
.premiere:after {
  background-color: hsla(120, 60%, 40%, 0.5);
  content: 'P';
  margin-left: 3px;
}
.live:after {
  background-color: hsla(0, 60%, 40%, 0.5);
  content: 'L';
}
.time {
  min-width: 50px;
  text-align: left;
}
.time:after {
  width: 11px;
  margin-left: 3px;
  border-radius: 4px;
  display: inline-block;
  text-align: center;
}
.progress {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: hsla(0, 0%, 75%, 0.3);
  z-index: -1;
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
  font-size: 11px;
  min-width: 42px;
  text-align: right;
  min-height: 20px;
}
'''
    ])
class TimeSlotComponent implements AfterViewInit {
  @Input()
  RbtvTimeSlot timeSlot;
  CssStyleDeclaration progressBar;
  ElementRef element;

  TimeSlotComponent(this.element);

  @override
  void ngAfterViewInit() {
    progressBar = ((element.nativeElement as HtmlElement)
            .querySelector('.progress') as HtmlElement)
        .style;
    var progress = timeSlot.getProgress();
    progressBar.width = '$progress%';
    if (progress == 0.0) {
      var timeUntilStart = timeSlot.start.difference(new DateTime.now());
      new Timer(timeUntilStart, () {
        _updateProgress();
      });
    } else if (progress < 100.0) {
      _updateProgress();
    }
  }

  void _updateProgress() {
    (element.nativeElement as HtmlElement).classes.add('current');
    var duration = timeSlot.getDuration();
    new Timer.periodic(
        new Duration(milliseconds: duration.inMilliseconds ~/ 3000),
        (Timer timer) {
      var progress = timeSlot.getProgress();
      if (progress >= 100.0) {
        (element.nativeElement as HtmlElement).classes.remove('current');
        timer.cancel();
      }
      progressBar.width = '$progress%';
    });
  }
}