import 'package:store/database/models/prodect_model.dart';

class CartItemModel {
  final ProdectModel item;
  double quantity;
  late double price;

  CartItemModel({required this.item, required this.quantity}) {
    price = item.price * quantity;
  }
  void increaseQuantity() {
    quantity = quantity + item.increaseAmount;
    price = item.price * quantity;
  }

  Map<String, dynamic> toMap() {
    return {
      'item': item.toMap(),
      'quantity': quantity,
      'price': price,
    };
  }

  static CartItemModel fromMap(price, Map<String, dynamic> map) {
    return CartItemModel(
        item: ProdectModel.fromMap(map['item']), quantity: map['quantity']);
  }
}
