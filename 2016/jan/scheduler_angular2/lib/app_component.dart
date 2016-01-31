library scheduler_angular2.app_component;

import 'package:angular2/angular2.dart';

import 'package:scheduler_angular2/day_component.dart';

import 'package:scheduler/scheduler.dart';

@Component(
    selector: 'my-app',
    template: '''
<div id="schedule">
  <schedule-day *ngFor="#day of days" [day]="day"></schedule-day>
</div>
    ''',
    directives: const [NgFor, DayComponent])
class AppComponent {
  List<Day> days;

  AppComponent(RbtvSchedulerService schedulerService) {
    schedulerService.getRbtvDays().then((days) {
      this.days = days;
      schedulerService.optimizeHeights(days, 20);
    });
  }
}
