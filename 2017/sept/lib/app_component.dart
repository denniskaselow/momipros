import 'package:angular/angular.dart';
import 'package:sept/src/services/is_it_weekend_yet_service.dart';
import 'package:sept/src/weekend_component/weekend_component.dart';
import 'package:sept/src/workweek_component/workweek_component.dart';

@Component(
    selector: 'is-it-weekend-yet',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: const [WeekendComponent, WorkweekComponent],
    providers: const [IsItWeekendYetService])
class AppComponent implements OnInit, OnDestroy {
  IsItWeekendYetService service;
  AppComponent(this.service);

  @override
  ngOnDestroy() {
    service.stopUpdate();
  }

  @override
  ngOnInit() {
    service.startUpdate();
  }
}
