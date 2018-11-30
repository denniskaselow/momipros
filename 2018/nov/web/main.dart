import 'package:vue/vue.dart';
import 'package:nov/nov.dart';

@VueApp(
  el: '#app',
  components: [
    PersonView,
  ],
)
class App extends VueAppBase {
  @data
  String name = 'World';
  @data
  List<Person> persons = [Person('Foo'), Person('Bar')];
}

App app;

void main() {
  app = App();
  app.create();
}
