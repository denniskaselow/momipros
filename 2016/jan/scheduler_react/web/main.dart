import 'dart:html';
import 'package:react/react_client.dart' as reactClient;
import 'package:react/react.dart';

main() {
  //this should be called once at the begging of application
  reactClient.setClientConfiguration();
  var component = div({}, "Hello world!");
  render(component, querySelector('#content'));
}