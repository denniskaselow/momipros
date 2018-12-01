class Person {
  String uuid;
  String name;
  List<Item> items = [];
  List<Item> rentedItems = [];
  Person(this.uuid, this.name);

  void addItem(Item item) {
    items.add(item);
    item.owner = this;
  }

  void rentItem(Item item) {
    item.renter = this;
    rentedItems.add(item);
  }

  void returnItem(Item item) {
    item.renter = null;
    rentedItems.remove(item);
  }
}

class Item {
  String uuid;
  Person owner;
  String name;
  String itemState;
  Person renter;
  Item(this.uuid, this.name, this.itemState);

  bool get rented => renter != null;
}