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
  List<Person> persons = personService.persons;
  @method
  void addPerson() {
    personService.addPerson(name);
  }
}

App app;

void main() {
  app = App();
  app.create();
}
