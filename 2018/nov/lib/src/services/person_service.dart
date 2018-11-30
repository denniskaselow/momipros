import 'package:nov/src/data_objects.dart';
import 'package:uuid/uuid.dart';

class PersonService {
  Uuid uuid = Uuid();
  List<Person> persons = [];

  void addPerson(String name) {
    if (name.isNotEmpty) {
      var person = Person(uuid.v4(), name);
      persons.add(person);
    }
  }

  void deletePerson(Person person) {
    persons.remove(person);
  }
}
