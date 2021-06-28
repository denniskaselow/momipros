library scheduler_angular2.app_component;

import 'package:angular/angular.dart';
import 'package:scheduler/scheduler.dart';

import 'day_component.dart';

@Component(selector: 'my-app', template: '''
<div id="schedule">
  <i class="fa fa-arrow-circle-left" (click)='move(-1)'></i>
  <schedule-day *ngFor="let day of days; trackBy:dateId" [day]="day" [class.today]='day.isToday' [ngClass]='day.dayName'></schedule-day>
  <i class="fa fa-arrow-circle-right" (click)='move(1)'></i>
</div>
    ''', styles: [
  '''
      #schedule {
          display: flex;
          justify-content: center;
          align-items: center;
      }
      .fa-arrow-circle-right, .fa-arrow-circle-left {
        font-size: 40px;
        text-align: center;
        cursor: pointer;
        color: #444;
      }
'''
], directives: [
  DayComponent,
  NgFor,
  NgClass,
], providers: [
  RbtvSchedulerService,
])
class AppComponent {
  int offset = 0;
  List<Day> days;
  RbtvSchedulerService schedulerService;
  DateTime currentDate = DateTime.now();

  AppComponent(this.schedulerService) {
    schedulerService.getRbtvDays(10, 30).then((days) {
      this.days = days;
      schedulerService.optimizeHeights(days, 15);
    });
  }

  void move(int change) {
    offset += change;
    schedulerService.getRbtvDays(10, 30, offset).then((days) {
      this.days = days;
      schedulerService.optimizeHeights(days, 15);
    });
  }

  Object dateId(int index, Object day) =>
      day is Day ? dateIdFormat.format(day.date) : day;
}
