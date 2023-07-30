// Import the FirebaseFirestore plugin.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/database/models/slider_model.dart';

CollectionReference slidersCollection =
    FirebaseFirestore.instance.collection('slides');

// get sliders
Future<List<SlideModel>> getSliders() async {
  final sliders = await slidersCollection.get();
  return sliders.docs
      .map((slide) => SlideModel.fromMap(slide.data() as Map<String, dynamic>))
      .toList();
}
