import 'dart:io';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:dson/dson.dart' as dson;
import 'package:scheduler/src/scheduler_base.dart';

const Map<String, int> months = const {
  'Jan': 1,
  'Feb': 2,
  'Mar': 3,
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
    RbtvTimeSlot show;
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
        var live = showDetails.querySelector('.live') != null;
        var premiere = showDetails.querySelector('.premiere') != null;
        var showDuration = showDetails.querySelector('.showDuration').text;
        var hourMinuteRegexp = new RegExp(r'((\d+) Std\. )?(\d+) Min\.');
        var matches = hourMinuteRegexp.allMatches(showDuration);
        var duration = 0;
        matches.forEach((match) {
          duration = int.parse(match.group(3));
          if (match.group(2) != null) {
            duration += 60 * int.parse(match.group(2));
          }
        });
        var hour = int.parse(time.split(':')[0]);
        var minute = int.parse(time.split(':')[1]);
        var startTime = new DateTime(year, month, day, hour, minute);
        var dummyEndTime = startTime.add(new Duration(minutes: duration));
        show = new RbtvTimeSlot(
            name, startTime, dummyEndTime, game, live, premiere);
        shows.add(show);
      });
      var duplicates = [];
      for (int i = 0; i < shows.length - 1; i++) {
        if (shows[i].start == shows[i + 1].start) {
          if (shows[i].end == shows[i + 1].end) {
            duplicates.add(i);
          } else {
            if (shows[i].end.isAfter(shows[i + 1].end)) {
              var tmp = shows[i];
              shows[i] = shows[i + 1];
              shows[i + 1] = tmp;
            } else
              shows[i + 1].start = shows[i].end;
          }
        }
        shows[i].end = shows[i + 1].start;
      }
      duplicates.reversed
          .forEach((duplicateIndex) => shows.removeAt(duplicateIndex));
      var path = 'lib/assets/rbtv/$year/${month.toString().padLeft(2, '0')}/';
      var file = await new File('$path${day.toString().padLeft(2, '0')}.json')
          .create(recursive: true);
      await file.writeAsString(dson.toJson(shows));
    });
  }
}
