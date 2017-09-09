import 'dart:html';
import 'package:angular/angular.dart';

@Injectable()
class IsItWeekendYetService {
  static const int dayInMilliseconds = 24 * 3600 * 1000;
  static const int workweekInMilliseconds = 5 * dayInMilliseconds;
  bool keepUpdating = false;
  DateTime currentTime = new DateTime.now();

  _updateCurrentTime([_]) {
    currentTime = new DateTime.now();
    if (keepUpdating) {
      window.animationFrame.then(_updateCurrentTime);
    }
  }

  bool get isItWeekendYet => currentTime.weekday > DateTime.FRIDAY;
  Duration getTimeUntilNextDay(int weekday) {
    if (weekday == currentTime.weekday) {
      var nextDay =
          new DateTime(currentTime.year, currentTime.month, currentTime.day)
              .add(const Duration(days: 1));
      return -currentTime.difference(nextDay);
    } else if (weekday < currentTime.weekday) {
      return const Duration();
    }
    return const Duration(hours: 24);
  }

  Duration getTimeUntilWeekend() {
    if (currentTime.weekday > DateTime.FRIDAY) {
      return const Duration();
    }
    var firstDayOfWeekend =
        new DateTime(currentTime.year, currentTime.month, currentTime.day);
    do {
      firstDayOfWeekend = firstDayOfWeekend.add(const Duration(days: 1));
    } while (firstDayOfWeekend.weekday != DateTime.SATURDAY);
    return -currentTime.difference(firstDayOfWeekend);
  }

  double getWeekProgress() =>
      1.0 - getTimeUntilWeekend().inMilliseconds / workweekInMilliseconds;

  double getDayProgress(int weekday) =>
      1.0 - getTimeUntilNextDay(weekday).inMilliseconds / dayInMilliseconds;

  void startUpdate() {
    keepUpdating = true;
    _updateCurrentTime();
  }

  void stopUpdate() {
    keepUpdating = false;
  }
}
