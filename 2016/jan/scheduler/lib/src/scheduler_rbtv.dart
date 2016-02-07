library scheduler.rbtv;

import 'dart:async';
import 'dart:html';

import 'package:scheduler/src/scheduler_base.dart';
import 'package:dson/dson.dart';

class RbtvSchedulerService extends SchedulerService {
  Map<String, List<RbtvTimeSlot>> showCache = <String, List<RbtvTimeSlot>>{};

  Future<List<Day>> getRbtvDays([int offset = 0]) async {
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

  Future<List<RbtvTimeSlot>> getRbtvTimeSlots(DateTime date) async {
    var dateId =
        '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
    var shows = showCache[dateId];
    if (null == shows) {
      try {
        var response = await HttpRequest
            .request('packages/scheduler/assets/rbtv/$dateId.json');
        var content = response.responseText;
        shows = fromJsonList(content, RbtvTimeSlot) as List<RbtvTimeSlot>;
        if (!(shows.first.start.hour == 0 && shows.first.start.minute == 0)) {
          var previousShows =
              await getRbtvTimeSlots(date.subtract(new Duration(days: 1)));
          var lastShow = previousShows.last;
          shows.insert(
              0,
              new RbtvTimeSlot(
                  lastShow.name,
                  new DateTime(date.year, date.month, date.day),
                  shows.first.start,
                  lastShow.description, lastShow.live, lastShow.premiere));
        }
        shows.last.end = new DateTime(
            shows.last.end.year, shows.last.end.month, shows.last.end.day);
      } catch (e) {
        shows = [];
      }
      _modifySpecialShows(shows);
      fillTimeSlots(shows, date);
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
      }
    });
  }
}
