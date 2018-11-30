import 'package:nov/src/services/person_service.dart';
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
  String name = '';
  @data
  List<Person> persons = stuffManagerService.persons;
  @method
  void addPerson() {
    stuffManagerService.addPerson(name);
  }
}

App app;

void main() {
  app = App();
  app.create();
}
