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
  flex-basis: 0;
}
:host.current {
  outline: 2px ridge #C2185B;
  outline-offset: -1px;
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
  CssStyleDeclaration progressBar;
  ElementRef element;

  TimeSlotComponent(this.element);

  @override
  void ngAfterViewInit() {
    progressBar = ((element.nativeElement as HtmlElement)
            .querySelector('.progress') as HtmlElement)
        .style;
    var progress = getProgress();
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
    new Timer.periodic(new Duration(milliseconds: duration.inMilliseconds ~/ 3000),
        (Timer timer) {
      var progress = getProgress();
      if (progress >= 100.0) {
        (element.nativeElement as HtmlElement).classes.remove('current');
        timer.cancel();
      }
      progressBar.width = '$progress%';
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
