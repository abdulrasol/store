class SildeModel {
  final String title;
  final String image;
  final String text;

  SildeModel({required this.title, required this.image, required this.text});

  Map<String, String> toMap() {
    return {
      'title': title,
      'image': image,
      'text': text,
    };
  }

  static SildeModel fromMap(Map<String, dynamic> map) {
    return SildeModel(
        title: map['title'], image: map['image'], text: map['text']);
  }
}
