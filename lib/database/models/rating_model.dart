class RatingModel {
  final String productId;
  final String user;
  final String reviewText;
  final String rating;
  final String timestamp;
  final String? userProfile;

  RatingModel({
    required this.productId,
    required this.user,
    required this.reviewText,
    required this.rating,
    required this.timestamp,
    this.userProfile,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'user': user,
      'reviewText': reviewText,
      'rating': rating,
      'timestamp': timestamp,
      'userProfile': userProfile,
    };
  }

  static RatingModel fromMap(Map<String, dynamic> map) {
    return RatingModel(
      productId: map['productId'],
      user: map['user'],
      reviewText: map['reviewText'],
      rating: map['rating'],
      timestamp: map['timestamp'],
    );
  }
}
