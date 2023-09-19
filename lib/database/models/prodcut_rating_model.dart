class ProdectRatingModel {
  final String user;
  final String prodcet;
  final double rating;
  final String? review;

  ProdectRatingModel({
    required this.user,
    required this.prodcet,
    required this.rating,
    required this.review,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'prodcet': prodcet,
      'rating': rating,
      'review': review,
    };
  }

  static ProdectRatingModel fromMap(Map<String, dynamic> data) {
    return ProdectRatingModel(
      user: data['user'],
      prodcet: data['prodcet'],
      rating: data['rating'],
      review: data['review'],
    );
  }
}
