// Import the FirebaseFirestore plugin.
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/prodect_model.dart';

// Create a reference to the products collection.
CollectionReference productsCollection =
    FirebaseFirestore.instance.collection('items');

// Get all the products from the collection.
Future<QuerySnapshot> getProducts() async {
  return await productsCollection.get();
}

// Get all the products from the collection.
/*
Future<List<ProdectModel>> getProductsList() async {
  return await productsCollection
      .get()
      .then((products) => products.docs.map((e) {
            return ProdectModel.fromMap(e.data() as Map<String, dynamic>);
          }).toList());
}
*/
Future<List<ProdectModel>> getProductsList() async {
  final products = await productsCollection.get();
  return products.docs.map((e) {
    return ProdectModel.fromMap(e.data() as Map<String, dynamic>);
  }).toList();
}

// Get all products as stream ignored
Stream<QuerySnapshot> getProductsAsStream() {
  var products = productsCollection.snapshots();

  return productsCollection.snapshots();
}

final Stream<QuerySnapshot> _usersStream =
    FirebaseFirestore.instance.collection('users').snapshots();

// Get a single product by ID.
Future<DocumentSnapshot> getProductById(String id) async {
  return await productsCollection.doc(id).get();
}

// Get Product that from search
Future<QuerySnapshot> getFilterdProducts(String text) async {
  Query query = productsCollection.where('name', isGreaterThanOrEqualTo: text);
  query = productsCollection.where('name',
      isLessThan:
          '${text}z'); // Optional: This ensures a case-insensitive search
  QuerySnapshot querySnapshot = await query.get();
  return querySnapshot;
}
// 07803281628
// 07719921810