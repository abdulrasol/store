import 'package:store/database/models/user_model.dart';

class RatingModel {
  final String productId;
  final UserModel user;
  final String reviewText;
  final String rating;
  final String timestamp;

  RatingModel(
      this.productId, this.user, this.reviewText, this.rating, this.timestamp);
}
