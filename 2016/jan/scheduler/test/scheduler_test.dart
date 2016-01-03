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
}
