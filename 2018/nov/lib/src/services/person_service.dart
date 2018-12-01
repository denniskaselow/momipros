import 'package:nov/src/data_objects.dart';
import 'package:uuid/uuid.dart';

class StuffManagerService {
  Uuid uuid = Uuid();
  List<Person> persons = [];
  static const Map<String, String> itemStates = {
    'sell': 'verkaufen',
    'rent': 'verleihen',
    'gift': 'verschenken'
  };

  void addPerson(String name) {
    if (name.isNotEmpty) {
      var person = Person(uuid.v4(), name);
      persons.add(person);
    }
  }

  void deletePerson(Person person) {
    persons.remove(person);
  }

  addItem(Person person, String newItem, String newItemState) {
    person.addItem(Item(person, uuid.v4(), newItem, newItemState));
  }

  deleteItem(Item item) {
    item.owner.items.remove(item);
  }
}
