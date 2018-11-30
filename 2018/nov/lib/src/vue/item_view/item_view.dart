import 'package:nov/nov.dart';
import 'package:vue/vue.dart';

@VueComponent(template: '<<')
class ItemView extends VueComponentBase {
  @prop
  Item item;
  @method
  void deleteItem() => stuffManagerService.deleteItem(item);
}
