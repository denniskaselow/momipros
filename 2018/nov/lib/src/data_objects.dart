class Person {
  String uuid;
  String name;
  List<Item> items = [];
  Person(this.uuid, this.name);

  void addItem(Item item) {
    items.add(item);
  }
}

class Item {
  String uuid;
  Person owner;
  String name;
  String itemState;
  Item(this.owner, this.uuid, this.name, this.itemState);
}