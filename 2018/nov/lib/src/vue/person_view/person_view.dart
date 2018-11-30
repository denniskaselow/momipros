import 'package:nov/nov.dart';
import 'package:vue/vue.dart';

@VueComponent(template: '<<')
class PersonView extends VueComponentBase {
  @prop
  Person person;
}
