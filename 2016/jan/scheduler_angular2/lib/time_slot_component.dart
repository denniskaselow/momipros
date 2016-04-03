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
<div class='progress' [style.width]='progressWidth'></div>
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
class TimeSlotComponent implements OnInit, OnDestroy {
  @Input()
  RbtvTimeSlot timeSlot;
  @HostBinding('class.current')
  bool current = false;
  Timer _progressTimer;
  double progressWidth = 0.0;

  @override
  void ngOnInit() {
    var progressWidth = timeSlot.getProgress();
    if (progressWidth == 0.0) {
      var timeUntilStart = timeSlot.start.difference(new DateTime.now());
      _progressTimer = new Timer(timeUntilStart, () {
        _updateProgress();
      });
    } else if (progressWidth < 100.0) {
      _updateProgress();
    }
  }

  @override
  void ngOnDestroy() {
    _progressTimer?.cancel();
  }

  void _updateProgress() {
    current = true;
    var duration = timeSlot.getDuration();
    _progressTimer = new Timer.periodic(
        new Duration(milliseconds: duration.inMilliseconds ~/ 3000),
        (Timer timer) {
      var progress = timeSlot.getProgress();
      if (progress >= 100.0) {
        current = false;
        timer.cancel();
      }
      progressWidth = progress;
    });
  }
}
