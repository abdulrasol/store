import 'package:firebase_auth/firebase_auth.dart';
import 'package:store/database/models/order_model.dart';
import 'cart_model.dart';
import 'user_adress.dart';

class UserModel {
  final User user;
  final List<OrderModel> orders;
  final CartModel cart;
  final UserAdress userAdress;

  UserModel(this.user, this.orders, this.cart, this.userAdress);
}
