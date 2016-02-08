library scheduler.rbtv;

import 'dart:async';
import 'dart:html';

import 'package:scheduler/src/scheduler_base.dart';
import 'package:dson/dson.dart';

class RbtvSchedulerService extends SchedulerService {
  Map<String, List<RbtvTimeSlot>> showCache = <String, List<RbtvTimeSlot>>{};

  Future<List<Day>> getRbtvDays(int startHour, int startMinute, [int offset = 0]) async {
    this.startHour = startHour;
    this.startMinute = startMinute;
    var today = new DateTime.now();
    today = today.add(new Duration(days: offset));
    var days = <Day>[];
    for (int i = -3; i <= 3; i++) {
      var day = today.add(new Duration(days: i));
      var timeSlots = await getRbtvTimeSlots(day);
      days.add(new Day(day, timeSlots));
    }
    return days;
  }

  Future<List<RbtvTimeSlot>> getRbtvTimeSlots(DateTime date, [bool goIntoPast = true]) async {
    var shows = await getRawRbtvTimeSlots(date);
    shows = shows
        .where((show) =>
            show.start.hour > startHour ||
            show.start.hour == startHour && show.start.minute >= startMinute)
        .toList();
    if (startHour != 0 || startMinute != 0) {
      var tomorrowShows = await getRawRbtvTimeSlots(date.add(new Duration(days: 1)));
      tomorrowShows = tomorrowShows.where((show) => show.start.hour < startHour ||
          show.start.hour == startHour && show.start.minute < startMinute).toList();
      shows.addAll(tomorrowShows);
    }
    if (goIntoPast && !(shows.first.start.hour == startHour &&
        shows.first.start.minute == startMinute)) {
      var previousShows =
          await getRbtvTimeSlots(date.subtract(new Duration(days: 1)), false);
      var lastShow = previousShows.last;
      shows.insert(
          0,
          new RbtvTimeSlot(
              lastShow.name,
              new DateTime(date.year, date.month, date.day, startHour, startMinute),
              shows.first.start,
              lastShow.description,
              lastShow.live,
              lastShow.premiere));
    }
    shows.last.end = new DateTime(
        shows.last.end.year, shows.last.end.month, shows.last.end.day, startHour, startMinute);
    _modifySpecialShows(shows);

    return shows;
  }

  Future<List<RbtvTimeSlot>> getRawRbtvTimeSlots(DateTime date) async {
    var dateId =
        '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
    var shows = showCache[dateId];
    if (null == shows) {
      try {
        var response = await HttpRequest
            .request('packages/scheduler/assets/rbtv/$dateId.json');
        var content = response.responseText;
        shows = fromJsonList(content, RbtvTimeSlot) as List<RbtvTimeSlot>;
      } catch (e) {
        shows = [];
      }
      showCache[dateId] = shows;
    }
    fillTimeSlots(shows, date);
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
      }
    });
  }

  @override
  TimeSlot getEmptyTimeSlot(DateTime start, DateTime end) {
    return new EmptyRbtvTimeSlot(start, end);
  }
}
