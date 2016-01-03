library scheduler_angular2.web;

import 'package:angular2/bootstrap.dart';
import 'package:angular2/angular2.dart';

import 'package:scheduler_angular2/app_component.dart';

import 'package:scheduler/scheduler.dart';

main() {
  bootstrap(AppComponent, [provide(SchedulerService, useValue: new SchedulerService())]);
}