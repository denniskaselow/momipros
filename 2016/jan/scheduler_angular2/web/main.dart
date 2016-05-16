library scheduler_angular2.web;

import 'package:angular2/platform/browser.dart';
import 'package:angular2/angular2.dart';

import 'package:scheduler_angular2/app_component.dart';

import 'package:scheduler/scheduler.dart';

void main() {
  bootstrap(AppComponent, [
    provide(RbtvSchedulerService, useValue: new RbtvSchedulerService())
  ]);
}
