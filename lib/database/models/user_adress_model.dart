class UserAdressModel {
  final String title;
  final String description;
  final String id;
  final double latitude;
  final double longitude;

  UserAdressModel({
    required this.id,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude
    };
  }

  static UserAdressModel fromMap(Map<String, dynamic> map) {
    return UserAdressModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}
