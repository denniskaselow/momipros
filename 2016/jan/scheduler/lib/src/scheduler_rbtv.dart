library scheduler.rbtv;

import 'dart:convert';
import 'dart:html';

import 'package:scheduler_base/scheduler_base.dart';

class RbtvSchedulerService extends SchedulerService {
  Map<String, List<RbtvTimeSlot>> showCache = <String, List<RbtvTimeSlot>>{};

  Future<List<Day>> getRbtvDays(int startHour, int startMinute,
      [int offset = 0]) async {
    this.startHour = startHour;
    this.startMinute = startMinute;
    var today = DateTime.now();
    today = today.add(Duration(days: offset));
    var days = <Day>[];
    for (int i = -3; i <= 3; i++) {
      var day = today.add(Duration(days: i));
      var timeSlots = await getRbtvTimeSlots(day);
      days.add(Day(day, timeSlots));
    }
    return days;
  }

  Future<List<RbtvTimeSlot>> getRbtvTimeSlots(DateTime date,
      [bool goIntoPast = true]) async {
    var shows = await getRawRbtvTimeSlots(date);
    var tomorrow = date.add(Duration(days: 1));
    shows = shows
        .where((show) =>
            show.start.hour > startHour ||
            show.start.hour == startHour && show.start.minute >= startMinute)
        .toList();
    if (startHour != 0 || startMinute != 0) {
      var tomorrowShows = await getRawRbtvTimeSlots(tomorrow);
      tomorrowShows = tomorrowShows
          .where((show) =>
              show.start.hour < startHour ||
              show.start.hour == startHour && show.start.minute < startMinute)
          .toList();
      shows.addAll(tomorrowShows);
    }
    if (shows.isNotEmpty) {
      for (int i = 0; i < shows.length - 1; i++) {
        shows[i].end = shows[i + 1].start;
      }
      if (goIntoPast &&
          !(shows.first.start.hour == startHour &&
              shows.first.start.minute == startMinute)) {
        var previousShows =
            await getRbtvTimeSlots(date.subtract(Duration(days: 1)), false);
        var lastShow = previousShows.last;
        shows.insert(
            0,
            RbtvTimeSlot(
                lastShow.name,
                DateTime(
                    date.year, date.month, date.day, startHour, startMinute),
                shows.first.start,
                lastShow.description,
                lastShow.live,
                lastShow.premiere));
      }
      var endOfDay = DateTime(
          tomorrow.year, tomorrow.month, tomorrow.day, startHour, startMinute);
      if (shows.last.end.isAfter(endOfDay)) {
        shows.last.end = endOfDay;
      }
      _modifySpecialShows(shows);
    }
    fillTimeSlots(shows, date);

    return shows;
  }

  Future<List<RbtvTimeSlot>> getRawRbtvTimeSlots(DateTime date) async {
    var dateId =
        '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
    var shows = showCache[dateId];
    if (null == shows) {
      try {
        var response = await HttpRequest.request(
            'https://scheduler-40abf.firebaseio.com/rbtv/$dateId.json');
        shows = _fromJsonList(response.responseText);
      } catch (e) {
        shows = [];
        fillTimeSlots(shows, date);
      }
      showCache[dateId] = shows;
    }
    return shows;
  }

  void _modifySpecialShows(List<RbtvTimeSlot> shows) {
    shows.forEach((show) {
      if (show.name == "Let’s Play") {
        show.name = show.description;
        show.description = "Let’s Play";
      } else if (show.name == "Knallhart Durchgenommen") {
        show.name = show.description;
        show.description = "Knallhart Durchgenommen";
      } else if (show.name == "Zocken mit Bohnen") {
        show.name = show.description;
        show.description = "Zocken mit Bohnen";
      }
    });
  }

  @override
  TimeSlot getEmptyTimeSlot(DateTime start, DateTime end) {
    return EmptyRbtvTimeSlot(start, end);
  }

  List<RbtvTimeSlot> _fromJsonList(String content) {
    List<dynamic> decoded = jsonDecode(content);
    return decoded.map((entry) => RbtvTimeSlot.decode(entry)).toList();
  }
}
