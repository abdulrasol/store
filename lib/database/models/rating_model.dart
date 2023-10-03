class UserRatingModel {
  final String productId;
  final Map user; // {'user_id: string, 'name': string}
  final String reviewText;
  final double rating;
  final String timestamp;

  UserRatingModel({
    required this.productId,
    required this.user,
    required this.reviewText,
    required this.rating,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'user': user,
      'reviewText': reviewText,
      'rating': rating,
      'timestamp': timestamp,
    };
  }

  static UserRatingModel fromMap(Map<String, dynamic> map) {
    return UserRatingModel(
      productId: map['productId'],
      user: map['user'],
      reviewText: map['reviewText'],
      rating: map['rating'],
      timestamp: map['timestamp'],
    );
  }
}
