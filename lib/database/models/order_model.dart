import 'package:store/database/models/item_card.dart';
import 'package:store/database/models/user_adress.dart';

class OrderModel {
  final String userId;
  final List<CartItemModel> items;
  final String timestamp;
  final UserAdress adress;
  final double price;
  final String state;

  OrderModel({
    required this.userId,
    required this.items,
    required this.timestamp,
    required this.adress,
    required this.price,
    required this.state,
  });
}
