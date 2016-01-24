library scheduler_angular2.app_component;

import 'package:angular2/angular2.dart';

import 'package:scheduler_angular2/day_component.dart';

import 'package:scheduler/scheduler.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    directives: const [NgFor, DayComponent])
class AppComponent {
  List<Day> days;

  AppComponent(SchedulerService schedulerService) {
    days = schedulerService.getDays();
    schedulerService.optimizeHeights(days, 40);
  }
}
