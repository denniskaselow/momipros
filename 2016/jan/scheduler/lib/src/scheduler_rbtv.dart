library scheduler.rbtv;

import 'dart:async';
import 'dart:html';

import 'package:scheduler/src/scheduler_base.dart';
import 'package:html/parser.dart' as parser;

const Map<String, int> months = const {
  'Jan': 1,
  'Feb': 2,
  'Nov': 11,
  'Dez': 12
};

class RbtvSchedulerService extends SchedulerService {

  Future<List<Day>> getRbtvDays() async {
    var today = new DateTime(2015, 11, 19);
    var days = <Day>[];
    for (int i = -3; i <= 3; i++) {
      var day = today.add(new Duration(days: i));
      var timeSlots = await getRbtvTimeSlots(day);
      days.add(new Day(day, timeSlots));
    }
    return days;
  }

  Future<List<TimeSlot>> getRbtvTimeSlots(DateTime date) async {
    var content =
    await HttpRequest.getString('packages/scheduler/assets/original.html');

    var document = parser.parse(content);

    var schedule = document.querySelector('#schedule');
    var scheduleDays = schedule.querySelectorAll('.day');
    TimeSlot show = null;
    var shows = <TimeSlot>[];
    scheduleDays.forEach((scheduleDay) {
      var dayDate = scheduleDay
          .querySelector('.dateHeader span')
          .text
          .split(new RegExp(r'\.? '));
      var scheduleShows = scheduleDay.querySelectorAll('.show');
      var year = int.parse(dayDate[2]);
      var month = months[dayDate[1]];
      var day = int.parse(dayDate[0]);
      var previousDay = date.subtract(new Duration(days: 1));
      if (year == date.year && month == date.month && day == date.day) {
        scheduleShows.forEach((scheduleShow) {
          var time = scheduleShow.querySelector('.scheduleTime').text;
          var showDetails = scheduleShow.querySelector('.showDetails');
          var name = showDetails.querySelector('h4').text;
          var game = showDetails.querySelector('.game')?.text;
          var hour = int.parse(time.split(':')[0]);
          var minute = int.parse(time.split(':')[1]);
          var startTime = new DateTime(year, month, day, hour, minute);
          var dummyEndTime =
          new DateTime(year, month, day).add(new Duration(days: 1));
          if (null != show) {
            show.end = startTime;
          } else {
            if (!(startTime.hour == 0 && startTime.minute == 0) && scheduleDay.previousElementSibling != null) {
              var lastShowOfPreviousDay = scheduleDay.previousElementSibling.querySelectorAll('.show').last.querySelector('.showDetails');
              show = new TimeSlot(lastShowOfPreviousDay.querySelector('h4').text + " cont'd", date, startTime);
              shows.add(show);
            }
          }
          show = new TimeSlot(name, startTime, dummyEndTime);
          shows.add(show);
        });
      }
    });
    fillTimeSlots(shows);
    return shows;
  }
}