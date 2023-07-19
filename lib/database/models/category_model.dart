class CategoryModel {
  final String id;
  final String name;
  final String image;
  final String description;

  CategoryModel({
    required this.name,
    required this.image,
    required this.description,
    required this.id,
  });

  Map<String, String> toMap() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'id': id,
    };
  }

  static CategoryModel fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'],
      image: map['image'],
      description: map['description'],
      id: map['id'],
    );
  }
}
