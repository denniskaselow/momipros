import 'package:vue/vue.dart';

@VueApp(el: '#app')
class App extends VueAppBase {
  @data
  String name = 'World';
}

App app;

void main() {
  app = App();
  app.create();
}
