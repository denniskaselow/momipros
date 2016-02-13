@HtmlImport('schedule_day.html')
library scheduler_polymer.lib.schedule_day;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'package:scheduler/scheduler.dart';

@PolymerRegister('schedule-day')
class ScheduleDay extends PolymerElement {
  @property
  Day day;
  String currentDayName = 'dummy';

  ScheduleDay.created() : super.created();

  @Observe('day')
  void changeDay(Day newDay) {
//    classes
//      ..remove(currentDayName)
//      ..add(day.dayName);
//    if (day.isToday) {
//      classes.add('today');
//    } else {
//      classes.remove('today');
//    }
//    currentDayName = day.dayName;
  }

  void expand(HtmlElement target) {
    if (target.classes.contains('today')) {
      target.style.flexGrow = '2';
    } else {
      target.style.flexGrow = '1.5';
    }
  }

  void shrink(HtmlElement target) {
    if (target.classes.contains('today')) {
      target.style.flexGrow = '1.5';
    } else {
      target.style.flexGrow = '1';
    }
  }
}
