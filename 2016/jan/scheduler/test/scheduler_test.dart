library scheduler.test;

import 'package:scheduler/scheduler.dart';
import 'package:test/test.dart';

void main() {
  group('TimeSlot', () {
    TimeSlot timeSlot;

    setUp(() {
      timeSlot = new TimeSlot('testing', new DateTime.utc(2016, 1, 3, 13, 37), new DateTime.utc(2016, 1, 3, 14, 00));
    });

    test('returns corret duration', () {
      expect(timeSlot.duration, equals(new Duration(minutes: 23)));
    });
  });
  group('SchedulerService', () {
    SchedulerService service;

    setUp(() {
      service = new SchedulerService();
    });

    test('returns last, current and next day', () {
      var days = service.getDays();
      var today = new DateTime.now();
      var yesterday = today.subtract(new Duration(days: 1));
      var tomorrow = today.add(new Duration(days: 1));

      expect(days.length, equals(3));
      expect(days[0].date.year, equals(yesterday.year));
      expect(days[0].date.month, equals(yesterday.month));
      expect(days[0].date.day, equals(yesterday.day));

      expect(days[1].date.year, equals(today.year));
      expect(days[1].date.month, equals(today.month));
      expect(days[1].date.day, equals(today.day));

      expect(days[2].date.year, equals(tomorrow.year));
      expect(days[2].date.month, equals(tomorrow.month));
      expect(days[2].date.day, equals(tomorrow.day));
    });
  });
}
