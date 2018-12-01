import 'package:nov/nov.dart';
import 'package:nov/src/services/person_service.dart';
import 'package:nov/src/vue/item_view/item_view.dart';
import 'package:vue/vue.dart';

@VueComponent(
  template: '<<',
  components: [
    ItemView,
  ],
)
class PersonView extends VueComponentBase {
  @data
  String newItem;
  @data
  String newItemState;
  @data
  List<Item> items;
  @prop
  Person person;
  @computed
  List<MapEntry<String, String>> get itemStates =>
      StuffManagerService.itemStates.entries.toList();

  @override
  void lifecycleCreated() => items = person.items;

  @method
  void deletePerson() => stuffManagerService.deletePerson(person);
  @method
  void addItem() => stuffManagerService.addItem(person, newItem, newItemState);
}
