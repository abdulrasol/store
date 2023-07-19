// Import the FirebaseFirestore plugin.
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference slidersCollection =
    FirebaseFirestore.instance.collection('slides');

// get sliders
Future<QuerySnapshot> getSliders() async {
  return await slidersCollection.get();
}
