library scheduler_angular2.time_slot_component;

import 'dart:async';

import 'package:over_react/over_react.dart';
import 'package:w_flux/w_flux.dart';
import 'package:scheduler/scheduler.dart';

@Factory()
UiFactory<TimeSlotProps> TimeSlotComponentFactory;

@Props()
class TimeSlotProps extends FluxUiProps<TimeSlotActions, TimeSlotStore> {}

@Component()
class TimeSlotComponent extends FluxUiComponent<TimeSlotProps> {
  @override
  void componentWillMount() {
    super.componentWillMount();
    props.actions.startProgress();
  }

  @override
  void componentWillUnmount() {
    super.componentWillUnmount();
    props.actions.stopProgress();
  }

  @override
  dynamic render() {
    return (Dom.div()
      ..style = {'flexGrow': props.store.timeSlot.height}
      ..className = 'timeslot ${props.store.isCurrent ? 'current' : ''}')([
      (Dom.div()
        ..className =
            'time ${props.store.timeSlot.live ? 'live' : ''} ${props.store.timeSlot.premiere ? 'premiere' : ''}'
        ..key = 'time')([props.store.timeSlot.getStartLabel()]),
      (Dom.div()
        ..className = 'content'
        ..key = 'content')([
        (Dom.div()
          ..className = 'name'
          ..key = 'name')([props.store.timeSlot.name]),
        (Dom.div()
          ..className = 'description'
          ..key = 'description')([props.store.timeSlot.description]),
      ]),
      (Dom.div()
        ..className = 'duration'
        ..key = 'duration')([props.store.timeSlot.getDurationLabel()]),
      (Dom.div()
        ..className = 'progress'
        ..key = 'progress'
        ..style = {'width': '${props.store.progress}%'})()
    ]);
  }
}

class TimeSlotActions {
  Action startProgress = new Action();
  Action updateProgress = new Action();
  Action initTimeSlot = new Action();
  Action stopProgress = new Action();
}

class TimeSlotStore extends Store {
  RbtvTimeSlot _timeSlot;
  double _progress;
  bool _isCurrent = false;
  String _timeSlotId;
  Timer _progressTimer;

  TimeSlotActions _actions;

  TimeSlotStore(this._actions, this._timeSlot) {
    triggerOnAction(_actions.updateProgress, _updateProgress);
    triggerOnAction(_actions.startProgress, _startProgress);
    triggerOnAction(_actions.stopProgress, _stopProgress);
    _timeSlotId = timeIdFormat.format(_timeSlot.start);
  }

  RbtvTimeSlot get timeSlot => _timeSlot;
  double get progress => _progress;
  bool get isCurrent => _isCurrent;
  String get timeSlotId => _timeSlotId;

  void _startProgress(_) {
    _progress = timeSlot.getProgress();
    if (_progress == 0.0) {
      var timeUntilStart = timeSlot.start.difference(new DateTime.now());
      _progressTimer = new Timer(timeUntilStart, () {
        _actions.updateProgress();
      });
    } else if (_progress < 100.0) {
      _actions.updateProgress();
    }
  }

  void _updateProgress(_) {
    var duration = timeSlot.getDuration();
    _progress = timeSlot.getProgress();
    if (progress >= 100.0) {
      _isCurrent = false;
    } else {
      _isCurrent = true;
      _progressTimer = new Timer(
          new Duration(milliseconds: duration.inMilliseconds ~/ 3000), () {
        _actions.updateProgress();
      });
    }
  }

  void _stopProgress(_) {
    _progressTimer?.cancel();
  }
}
