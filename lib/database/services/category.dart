// Import the FirebaseFirestore plugin.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/database/models/category_model.dart';
import 'package:store/database/services/items.dart';

// Create a reference to the products collection.
CollectionReference categoriesCollection =
    FirebaseFirestore.instance.collection('categories');

// Get all the products from the collection.
Future<QuerySnapshot> getCategories() async {
  return await categoriesCollection.get();
}

// Get all Category to Category List:
Future<List<CategoryModel>> getCategoriesList() async {
  final categories = await categoriesCollection.get();
  return categories.docs
      .map((cat) => CategoryModel.fromMap(cat.data() as Map<String, dynamic>))
      .toList();
}

// Filter the documents to only include those with the specified category
Future<QuerySnapshot> getCategoryProducts({required String category}) async {
  return await productsCollection.where('category', isEqualTo: category).get();
}
