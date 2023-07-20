// Import the FirebaseFirestore plugin.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/database/services/items.dart';

// Create a reference to the products collection.
CollectionReference categoriesCollection =
    FirebaseFirestore.instance.collection('categories');

// Get all the products from the collection.
Future<QuerySnapshot> getCategories() async {
  return await categoriesCollection.get();
}

// Filter the documents to only include those with the specified category
Future<QuerySnapshot> getCategoryProducts({required String category}) async {
  return await productsCollection.where('category', isEqualTo: category).get();
}
