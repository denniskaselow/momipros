library scheduler_angular2.app_component;

import 'package:angular2/angular2.dart';

import 'package:scheduler_angular2/day_component.dart';

import 'package:scheduler/scheduler.dart';

@Component(
    selector: 'my-app',
    template: '''
<div id="schedule">
  <i class="fa fa-arrow-circle-left" (click)='move(-1)'></i>
  <schedule-day *ngFor="#day of days" [day]="day"></schedule-day>
  <i class="fa fa-arrow-circle-right" (click)='move(1)'></i>
</div>
    ''',
    styles: const [
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
      }
'''
    ],
    directives: const [
      NgFor,
      DayComponent
    ])
class AppComponent {
  int offset = 0;
  List<Day> days;
  RbtvSchedulerService schedulerService;

  AppComponent(this.schedulerService) {
    schedulerService.getRbtvDays().then((days) {
      this.days = days;
      schedulerService.optimizeHeights(days, 15);
    });
  }

  void move(int change) {
    offset += change;
    schedulerService.getRbtvDays(offset).then((days) {
      this.days = days;
      schedulerService.optimizeHeights(days, 15);
    });
  }
}
