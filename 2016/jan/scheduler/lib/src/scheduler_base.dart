library scheduler.base;

import 'dart:math';

import 'package:intl/intl.dart';

class TimeSlot extends Object with HeightMixin {
  String name, description;
  DateTime start, end;
  Duration duration;
  TimeSlot(this.name, this.start, this.end, {this.description: ''}) {
    duration = end.difference(start);
  }
  String get startLabel => timeFormat.format(start);
  String get durationLabel => '${duration.inMinutes} min';
}

class EmptyTimeSlot extends TimeSlot {
  EmptyTimeSlot(DateTime start, DateTime end) : super('', start, end);
}

class Day extends Object with HeightMixin {
  DateTime date;
  List<TimeSlot> timeSlots;
  Day(this.date, [this.timeSlots = const []]);
  String get label => dateFormat.format(date);
}

class SchedulerService {
  DateTime _today = new DateTime.now();

  List<Day> getDays() {
    var today = new DateTime.now();
    var days = [
      new Day(today.subtract(new Duration(days: 1)),
          getTimeSlots(today.subtract(new Duration(days: 1)))),
      new Day(today, getTimeSlots(today)),
      new Day(today.add(new Duration(days: 1)),
          getTimeSlots(today.add(new Duration(days: 1))))
    ];
    return days;
  }

  List<TimeSlot> getTimeSlots(DateTime date) {
    var random = new Random();
    var start = new DateTime(date.year, date.month, date.day,
        random.nextInt(24), random.nextInt(60));
    var end = start.add(new Duration(minutes: 5 + random.nextInt(180)));
    var timeSlot = new TimeSlot('Testing', start, end);
    var timeSlots = [timeSlot];
    fillTimeSlots(timeSlots);
    return timeSlots;
  }

  void fillTimeSlots(List<TimeSlot> timeSlots) {
    var current = timeSlots.first;
    var emptySlot = new EmptyTimeSlot(
        new DateTime(
            current.start.year, current.start.month, current.start.day),
        new DateTime(current.start.year, current.start.month, current.start.day,
            current.start.hour, current.start.minute));
    if (emptySlot.duration.inMinutes > 0) {
      timeSlots.insert(0, emptySlot);
    }

    emptySlot = new EmptyTimeSlot(
        new DateTime(current.end.year, current.end.month, current.end.day,
            current.end.hour, current.end.minute),
        new DateTime(current.end.year, current.end.month, current.end.day)
            .add(new Duration(days: 1)));
    if (emptySlot.duration.inMinutes > 0) {
      timeSlots.add(emptySlot);
    }
  }

  void optimizeHeights(List<Day> days, int minHeight) {
    var shortSlots = <TimeSlot>[];
    for (var day in days) {
      for (var timeSlot in day.timeSlots) {
        timeSlot.height = timeSlot.duration.inMinutes;
        if (timeSlot.height < minHeight) {
          shortSlots.add(timeSlot);
        }
      }
    }
    var startTime = _getStartTimeHM(0, 0);
    var shortestSlot;
    var diffOfShortestSlot;
    var slots = [];
    do {
      for (var day in days) {
        for (var timeSlot in day.timeSlots) {
          var diff = _getEndTime(timeSlot).difference(startTime);
          if (diff.inMinutes <= 0) continue;
          if (null == shortestSlot || diff < diffOfShortestSlot) {
            shortestSlot = timeSlot;
            diffOfShortestSlot = diff;
          }
          slots.add(timeSlot);
          break;
        }
      }
      var endTime = _getEndTime(shortestSlot);
      var duration = endTime.difference(startTime);
      if (duration.inMinutes > minHeight) {
        slots.forEach((slot) {
          slot.height -= duration.inMinutes - minHeight;
        });
      }
      startTime = endTime;
      shortestSlot = null;
      slots = [];
    } while (!(startTime.hour == 0 && startTime.minute == 0));

    for (var shortSlot in shortSlots) {
      var startTime =
          _getStartTimeHM(shortSlot.start.hour, shortSlot.start.minute);
      var endTime = _getEndTime(shortSlot);
      for (var day in days) {
        if (shortSlot.start.day == day.date.day &&
            shortSlot.start.month == day.date.month) continue;
        for (var timeSlot in day.timeSlots) {
          var otherStartTime = _getStartTime(timeSlot);
          var otherEndTime = _getEndTime(timeSlot);
        }
      }
    }
  }

  DateTime _getEndTime(TimeSlot timeSlot) {
    var baseDate = _today;
    if (timeSlot.end.hour == 0 && timeSlot.end.minute == 0) {
      baseDate = baseDate.add(new Duration(days: 1));
    }
    return new DateTime(baseDate.year, baseDate.month, baseDate.day,
        timeSlot.end.hour, timeSlot.end.minute);
  }

  DateTime _getStartTimeHM(hour, minute) =>
      new DateTime(_today.year, _today.month, _today.day, hour, minute);

  DateTime _getStartTime(TimeSlot timeSlot) => new DateTime(
      _today.year, _today.month, _today.day, timeSlot.start.hour, timeSlot.start.minute);
}

class HeightMixin {
  int height;
}

final DateFormat dateFormat = new DateFormat.yMEd();
final DateFormat timeFormat = new DateFormat.Hm();
