import 'package:angular/angular.dart';
import 'package:sept/src/services/is_it_weekend_yet_service.dart';

@Component(selector: 'weekend', template: '{{label}}', styles: const [
  '''
:host {
  text-align: center;
  font-size: 8vw;
}
:host:not(.yes) {
  background: linear-gradient(to bottom, transparent, #FA016D 6vw);  
  margin-top: -6vw;
  padding-top: 6vw;
}
:host.yes {
  background-color: #A0FE65;
}
'''
])
class WeekendComponent {
  @HostBinding('class.yes')
  bool get isItWeekendYet => service.isItWeekendYet;
  IsItWeekendYetService service;

  WeekendComponent(this.service);

  String get label =>
      service.isItWeekendYet ? 'Wochenende!!!' : 'Noch kein Wochenende :(';
}
