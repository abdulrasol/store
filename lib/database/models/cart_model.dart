import 'package:store/database/models/item_card.dart';

class CartModel {
  final String userId;
  final List<CartItemModel> items;
  late double totalPrice;

  CartModel({
    required this.userId,
    required this.items,
  }) {
    for (var item in items) {
      totalPrice += item.price;
    }
  }
}
