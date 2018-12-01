import 'package:nov/nov.dart';
import 'package:nov/src/services/person_service.dart';
import 'package:vue/vue.dart';

@VueComponent(template: '<<')
class ItemView extends VueComponentBase {
  @data
  Person target;
  @data
  String currentState;
  @prop
  Item item;


  @override
  void lifecycleCreated() {
    currentState = item.itemState;
  }

  @computed
  List<MapEntry<String, String>> get itemStates =>
      StuffManagerService.itemStates.entries.toList();
  @computed
  List<Person> get persons => stuffManagerService.persons
      .where((person) => person.uuid != item.owner.uuid)
      .toList();
  @method
  void deleteItem() => stuffManagerService.deleteItem(item);
  @method
  void returnItem() => stuffManagerService.returnItem(item);
  @method
  void doAction() => stuffManagerService.doAction(currentState, target, item);
  @watch('currentState')
  void stateChanged() => item.itemState = currentState;
}
