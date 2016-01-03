library scheduler.base;

import 'dart:math';

import 'package:intl/intl.dart';

class TimeSlot {
  String name, description;
  DateTime start, end;
  Duration duration;
  TimeSlot(this.name, this.start, this.end, {this.description: ''}) {
    duration = end.difference(start);
  }
  String get startLabel => timeFormat.format(start);
  String get durationLabel => '${duration.inMinutes} min';
}

class Day {
  DateTime date;
  List<TimeSlot> timeSlots;
  Day(this.date, [this.timeSlots = const []]);
  String get label => dateFormat.format(date);
}

class SchedulerService {
  List<Day> getDays() {
    var today = new DateTime.now();
    var days = [
      new Day(today.subtract(new Duration(days: 1)), _getTimeSlots(today.subtract(new Duration(days: 1)))),
      new Day(today, _getTimeSlots(today)),
      new Day(today.add(new Duration(days: 1)), _getTimeSlots(today.add(new Duration(days: 1))))
    ];
    return days;
  }

  List<TimeSlot> _getTimeSlots(DateTime date) {
    var random = new Random();
    var start = new DateTime.utc(date.year, date.month, date.day,
        random.nextInt(24), random.nextInt(60));
    var end = start.add(new Duration(minutes: 5 + random.nextInt(180)));
    return [new TimeSlot('Testing', start, end)];
  }
}

final DateFormat dateFormat = new DateFormat.yMEd();
final DateFormat timeFormat = new DateFormat.Hm();