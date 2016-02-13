@HtmlImport('main_app.html')
library scheduler_polymer.lib.main_app;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'package:scheduler/scheduler.dart';

@PolymerRegister('main-app')
class MainApp extends PolymerElement {
  int _offset = 0;
  @property
  List<Day> days;
  RbtvSchedulerService schedulerService;
  DateTime currentDate = new DateTime.now();

  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created();

  void ready() {
    schedulerService = new RbtvSchedulerService();
    schedulerService.getRbtvDays(10, 30).then((days) {
      schedulerService.optimizeHeights(days, 15);
      set('days', days);
    });
  }

  @reflectable
  void moveLeft(event, [_]) => move(-1);
  @reflectable
  void moveRight(event, [_]) => move(1);

  void move(int change) {
    _offset += change;
    schedulerService.getRbtvDays(10, 30, _offset).then((days) {
      schedulerService.optimizeHeights(days, 15);
      set('days', days);
    });
  }
}
