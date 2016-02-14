import 'dart:html';
import 'package:react/react_client.dart' as reactClient;
import 'package:react/react.dart';
import 'package:scheduler_react/app_component.dart';
import 'package:scheduler/scheduler.dart';

main() {
  // initialize action, stores, and components
  AppActions actions = new AppActions();
  AppStore store = new AppStore(actions, new RbtvSchedulerService());

  reactClient.setClientConfiguration();

  render(appComponent({'actions': actions, 'store': store}), querySelector('#content'));
}