// Import the FirebaseFirestore plugin.
import 'package:cloud_firestore/cloud_firestore.dart';

// Create a reference to the products collection.
CollectionReference productsCollection =
    FirebaseFirestore.instance.collection('items');

// Get all the products from the collection.
Future<QuerySnapshot> getProducts() async {
  return await productsCollection.get();
}

// Get a single product by ID.
Future<DocumentSnapshot> getProductById(String id) async {
  return await productsCollection.doc(id).get();
}
