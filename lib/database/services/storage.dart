import 'package:firebase_storage/firebase_storage.dart';

final storageRef = FirebaseStorage.instance.ref();
final userProfileRef = storageRef.child('user_profile');
