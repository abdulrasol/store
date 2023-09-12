import 'dart:typed_data';

class UserModel {
  final String profileImage;
  late Uint8List imageData;

  UserModel({
    required this.profileImage,
  }) {
    List<int> data = profileImage.codeUnits;
    Uint8List bytes = Uint8List.fromList(data);
  }
}
