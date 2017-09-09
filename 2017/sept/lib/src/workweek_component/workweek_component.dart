import 'package:angular/angular.dart';
import 'package:sept/src/services/is_it_weekend_yet_service.dart';
import 'package:sept/src/workday_component/workday_component.dart';

@Component(
  selector: 'workweek',
  template: '''
<workday *ngFor='let workday of workweek' 
  [weekday]='workday'></workday>
''',
  styles: const [
    '''
  :host {
    display: grid;
    grid-template-columns: repeat(5, 20vw);
    justify-items: stretch;
    align-items: stretch;
  }
'''
  ],
  directives: const [WorkdayComponent, NgFor],
)
class WorkweekComponent {
  final List<int> workweek = [
    DateTime.MONDAY,
    DateTime.TUESDAY,
    DateTime.WEDNESDAY,
    DateTime.THURSDAY,
    DateTime.FRIDAY
  ];
  @HostBinding('style.background')
  String get background =>
      'linear-gradient(to right, #A0FE65 $greenColorStop%, #FA016D $redColorStop%';

  IsItWeekendYetService service;

  WorkweekComponent(this.service);

  double get greenColorStop => -20 + service.getWeekProgress() * 120;
  double get redColorStop => service.getWeekProgress() * 120;
}
