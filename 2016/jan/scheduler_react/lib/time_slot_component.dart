library scheduler_angular2.time_slot_component;

import 'dart:async';

import 'package:w_flux/w_flux.dart';
import 'package:react/react.dart';
import 'package:scheduler/scheduler.dart';

final timeSlotComponent = registerComponent(() => new _TimeSlotComponent());

class _TimeSlotComponent extends FluxComponent<TimeSlotActions, TimeSlotStore> {
  @override
  componentWillMount() {
    super.componentWillMount();
    actions.startProgress();
  }

  @override
  componentWillUnmount() {
    super.componentWillUnmount();
    actions.stopProgress();
  }

  @override
  render() {
    return div({
      'style': {'flexGrow': store.timeSlot.height},
      'className': 'timeslot ${store.isCurrent ? 'current' : ''}'
    }, [
      div({
        'className':
            'time ${store.timeSlot.live ? 'live' : ''} ${store.timeSlot.premiere ? 'premiere' : ''}',
        'key': 'time'
      }, [
        store.timeSlot.getStartLabel()
      ]),
      div({
        'className': 'content',
        'key': 'content'
      }, [
        div({'className': 'name', 'key': 'name'}, [store.timeSlot.name]),
        div({'className': 'description', 'key': 'description'},
            [store.timeSlot.description]),
      ]),
      div({'className': 'duration', 'key': 'duration'},
          [store.timeSlot.getDurationLabel()]),
      div({
        'className': 'progress',
        'key': 'progress',
        'style': {'width': '${store.progress}%'}
      })
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

  RbtvTimeSlot get timeSlot => _timeSlot;
  double get progress => _progress;
  bool get isCurrent => _isCurrent;
  String get timeSlotId => _timeSlotId;

  TimeSlotActions _actions;

  TimeSlotStore(this._actions, this._timeSlot) {
    triggerOnAction(_actions.updateProgress, _updateProgress);
    triggerOnAction(_actions.startProgress, _startProgress);
    triggerOnAction(_actions.stopProgress, _stopProgress);
    _timeSlotId = timeIdFormat.format(_timeSlot.start);
  }

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
