import 'dart:html';
import 'package:react/react_client.dart' as react_client;
import 'package:react/react_dom.dart' as react_dom;
import 'package:scheduler_react/app_component.dart';
import 'package:scheduler/scheduler.dart';

void main() {
  // initialize action, stores, and components
  AppActions actions = new AppActions();
  AppStore store = new AppStore(actions, new RbtvSchedulerService());

  react_client.setClientConfiguration();

  react_dom.render(appComponent({'actions': actions, 'store': store}), querySelector('#content'));
}