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
    person
      ..rentedItems.forEach(returnItem)
      ..items.where((item) => item.rented).forEach(returnItem);
    persons.remove(person);
  }

  void addItem(Person person, String newItem, String newItemState) {
    person.addItem(Item(uuid.v4(), newItem, newItemState));
  }

  void deleteItem(Item item) {
    item.owner.items.remove(item);
  }

  void doAction(String action, Person target, Item item) {
    if (action == 'sell' || action == 'gift') {
      deleteItem(item);
      target.addItem(item);
    } else if (action == 'rent') {
      target.rentItem(item);
    }
  }

  returnItem(Item item) {
    item.renter.returnItem(item);
  }
}
