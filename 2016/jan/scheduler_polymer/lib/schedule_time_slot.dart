@HtmlImport('schedule_time_slot.html')
library scheduler_polymer.lib.schedule_time_slot;

import 'dart:async';
import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'package:scheduler/scheduler.dart';

@PolymerRegister('schedule-time-slot')
class ScheduleTimeSlot extends PolymerElement {
  @property
  RbtvTimeSlot timeSlot;

  CssStyleDeclaration progressBar;

  ScheduleTimeSlot.created() : super.created();

  void ready() {
    if (timeSlot.live) {
      classes.add('live');
    } else if (timeSlot.premiere) {
      classes.add('premiere');
    }
    progressBar = this.querySelector('.progress').style;
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
    classes.add('current');
    var duration = timeSlot.getDuration();
    new Timer.periodic(
        new Duration(milliseconds: duration.inMilliseconds ~/ 3000),
        (Timer timer) {
      var progress = getProgress();
      if (progress >= 100.0) {
        classes.remove('current');
        timer.cancel();
      }
      progressBar.width = '$progress%';
    });
  }

  void expand(HtmlElement target) {}
  void shrink(HtmlElement target) {}

  @property
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

  @Property(computed: 'getStartLabel(timeSlot)')
  String startLabel;

  @reflectable
  String getStartLabel(RbtvTimeSlot timeSlot) => timeSlot.getStartLabel();

  @Property(computed: 'getDurationLabel(timeSlot)')
  String durationLabel;

  @reflectable
  String getDurationLabel(RbtvTimeSlot timeSlot) => timeSlot.getDurationLabel();
}
