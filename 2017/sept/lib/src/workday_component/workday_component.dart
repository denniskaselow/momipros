import 'package:angular/angular.dart';
import 'package:sept/src/services/is_it_weekend_yet_service.dart';

@Component(selector: 'workday', template: '''
<div>
  <div class='name' [ngStyle]=dayNameFontSize>{{dayName}}</div>
  <div class='countdown' [ngSwitch]='isDayOver' [ngStyle]=countdownFontSize>
    <template [ngSwitchCase]='true'>
      vorbei!
    </template>
    <template ngSwitchDefault>
      <span>{{countdown}}</span>
    </template>
  </div>
</div>

''', styles: const [
  '''
:host {
  display: grid;
}
div {
  margin: auto;
  text-align: center;
}
.name {
  font-size: 4vw;
}
.countdown {
  font-size: 1vw;
}
.countdown span {
  font-family: Consolas;
}
'''
], directives: const [
  NgIf,
  NgStyle,
  NgSwitch,
  NgSwitchWhen,
  NgSwitchDefault
])
class WorkdayComponent {
  static const List<String> dayNames = const [
    'Sonntag',
    'Montag',
    'Dienstag',
    'Mittwoch',
    'Donnerstag',
    'Freitag',
    'Samstag'
  ];
  @Input()
  int weekday;

  IsItWeekendYetService service;
  WorkdayComponent(this.service);

  String get dayName => WorkdayComponent.dayNames[weekday];
  String get countdown {
    final timeWithMicroSeconds =
        service.getTimeUntilNextDay(weekday).toString();
    return timeWithMicroSeconds.substring(0, timeWithMicroSeconds.length - 3);
  }

  bool get isDayOver =>
      service.getTimeUntilNextDay(weekday).inMicroseconds == 0;

  Map<String, String> get countdownFontSize {
    var dayProgress = service.getDayProgress(weekday);
    return {'font-size': '${1 + 2.2 * dayProgress*dayProgress}vw'};
  }

  Map<String, String> get dayNameFontSize {
    var dayProgress = service.getDayProgress(weekday);
    return {'font-size': '${4 - 3.5 * dayProgress*dayProgress}vw'};
  }
}
