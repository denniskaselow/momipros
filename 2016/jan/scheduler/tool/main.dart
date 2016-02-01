import 'dart:io';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:dson/dson.dart' as dson;
import 'package:scheduler/src/scheduler_base.dart';

const Map<String, int> months = const {
  'Jan': 1,
  'Feb': 2,
  'Mär': 3,
  'Apr': 4,
  'Mai': 5,
  'Jun': 6,
  'Jul': 7,
  'Aug': 8,
  'Sep': 9,
  'Okt': 10,
  'Nov': 11,
  'Dez': 12
};

Future<Null> main() async {
  var response = await http.get('http://www.rocketbeans.tv/wochenplan/');
  if (response.statusCode == HttpStatus.OK) {
    var content = response.body;
    var document = parser.parse(content);

    var schedule = document.querySelector('#schedule');
    var scheduleDays = schedule.querySelectorAll('.day');
    TimeSlot show = null;
    scheduleDays.forEach((scheduleDay) async {
      var shows = <TimeSlot>[];
      var dayDate = scheduleDay
          .querySelector('.dateHeader span')
          .text
          .split(new RegExp(r'\.? '));
      var scheduleShows = scheduleDay.querySelectorAll('.show');
      var year = int.parse(dayDate[2]);
      var month = months[dayDate[1]];
      var day = int.parse(dayDate[0]);
      scheduleShows.forEach((scheduleShow) {
        var time = scheduleShow.querySelector('.scheduleTime').text;
        var showDetails = scheduleShow.querySelector('.showDetails');
        var name = showDetails.querySelector('h4').text;
        var game = showDetails.querySelector('.game')?.text ?? '';
        var hour = int.parse(time.split(':')[0]);
        var minute = int.parse(time.split(':')[1]);
        var startTime = new DateTime(year, month, day, hour, minute);
        var dummyEndTime =
            new DateTime(year, month, day).add(new Duration(days: 1));
        if (null != show) {
          show.end = startTime;
        }
        show = new TimeSlot(name, startTime, dummyEndTime, game);
        shows.add(show);
      });
      var path = 'lib/assets/rbtv/$year/${month.toString().padLeft(2, '0')}/';
      var file = await new File('$path${day.toString().padLeft(2, '0')}.json')
          .create(recursive: true);
      await file.writeAsString(dson.toJson(shows));
    });
  }
}