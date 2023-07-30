class SlideModel {
  final String title;
  final String image;
  final String text;

  SlideModel({required this.title, required this.image, required this.text});

  Map<String, String> toMap() {
    return {
      'title': title,
      'image': image,
      'text': text,
    };
  }

  static SlideModel fromMap(Map<String, dynamic> map) {
    return SlideModel(
        title: map['title'], image: map['image'], text: map['text']);
  }
}
