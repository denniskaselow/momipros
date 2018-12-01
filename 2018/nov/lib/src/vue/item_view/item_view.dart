import 'package:nov/nov.dart';
import 'package:nov/src/services/person_service.dart';
import 'package:vue/vue.dart';

@VueComponent(template: '<<')
class ItemView extends VueComponentBase {
  @prop
  Item item;
  @computed
  List<MapEntry<String, String>> get itemStates =>
      StuffManagerService.itemStates.entries.toList();
  @method
  void deleteItem() => stuffManagerService.deleteItem(item);
}
