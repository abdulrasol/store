import 'package:store/database/models/prodect_model.dart';

class CartItem {
  final ProdectModel item;
  double quantity;
  late double price;

  CartItem(this.item, this.quantity) {
    price = item.price * quantity;
  }
  void increaseQuantity() {
    quantity = quantity + item.increaseAmount;
    price = item.price * quantity;
  }

  void decreaseQuantity() {
    quantity = quantity - item.increaseAmount;
    price = item.price * quantity;
  }
}
