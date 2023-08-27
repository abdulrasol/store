// Import the FirebaseFirestore plugin.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:store/database/models/item_card.dart';
import 'package:store/database/services/controller.dart';

import '../models/prodect_model.dart';

final controller = Get.put(Controller());
// Create a reference to the products collection.
CollectionReference productsCollection =
    FirebaseFirestore.instance.collection('items');

// Get all the products from the collection.
Future<QuerySnapshot> getProducts() async {
  return await productsCollection.get();
}

// Get all the products from the collection.
Future<List<ProdectModel>> getProductsList() async {
  final products = await productsCollection.get();
  return products.docs.map((e) {
    return ProdectModel.fromMap(e.data() as Map<String, dynamic>);
  }).toList();
}

// Get all products as stream ignored
Stream<QuerySnapshot> getProductsAsStream() {
  return productsCollection.snapshots();
}

//final Stream<QuerySnapshot> _usersStream =
//    FirebaseFirestore.instance.collection('users').snapshots();

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

// add item to user cart
Future<String?> addCartToCart(CartItemModel item) async {
  if (FirebaseAuth.instance.currentUser != null) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .add(item.toMap());
    return null;
  } else {
    return 'Please login first!';
  }
}

// get cart items
Future<List<CartItemModel>> getCartItems() async {
  final items = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('cart')
      .get();

  return items.docs.map((e) {
    final item = e.data()['item'];
    final id = e.id;
    final quantity = e.data()['quantity'];

    return CartItemModel(
      id: id,
      quantity: quantity,
      item: ProdectModel.fromMap(item),
    );
  }).toList();
}

// as stream
Stream<QuerySnapshot<Map<String, dynamic>>> getCartAsStream = FirebaseFirestore
    .instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('cart')
    .snapshots();

Stream<List<CartItemModel>> cartItemsStream = getCartAsStream.map((snapshot) {
  return snapshot.docs.map((doc) {
    final data = doc.data();
    final item = ProdectModel.fromMap(data['item']);
    final id = doc.id;
    final quantity =
        data['quantity'] as double; // or int, depending on your data type
    return CartItemModel(id: id, item: item, quantity: quantity);
  }).toList();
});

// delete cart items

Future<String?> deleteCartItem(String id) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .doc(id)
        .delete();
    return null;
  } on Exception {
    return 'Error';
  }
}
