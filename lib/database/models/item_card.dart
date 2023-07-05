import 'package:store/database/models/item_model.dart';

class CartItem {
  final ItemModel item;
  double quantity;
  late double price;

  CartItem(this.item, this.quantity) {
    price = item.price * quantity;
  }
  void increaseQuantity() {
    quantity = quantity + item.unit;
    price = item.price * quantity;
  }

  void decreaseQuantity() {
    quantity = quantity - item.unit;
    price = item.price * quantity;
  }
}
