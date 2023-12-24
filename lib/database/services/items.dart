// Import the FirebaseFirestore plugin.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:store/database/models/item_card.dart';
import 'package:store/database/models/order_model.dart';
import 'package:store/database/models/rating_model.dart';
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
    var prodectData = e.data() as Map<String, dynamic>;
    prodectData['id'] = e.id;
    return ProdectModel.fromMap(prodectData);
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

// add total price in card

Future calculateItemsPrice() async {
  controller.totalPrice.value = 0;
  controller.discount.value = 0;
  var cart = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('cart')
      .get();
  controller.itemsPrices.value = 0;
  for (var element in cart.docs) {
    controller.itemsPrices.value += element['price'] * element['quantity'];
  }
}

// add reivew

Future<int?> addReview(UserRatingModel reivew) async {
  try {
    await FirebaseFirestore.instance
        .collection('items') // Top-level collection
        .doc(reivew.productId) // Document ID
        .collection('reviews') // Subcollection name
        .doc(reivew.timestamp) // Add ID from time span
        .set(reivew.toMap()); // Add the document data
  } on Exception {
    return 1;
  }
  return 0;
}

// get product reivews
Future<List<UserRatingModel>> getProductReivews(
    {required String productId}) async {
  final app = await FirebaseFirestore.instance
      .collection('items') // Top-level collection
      .doc(productId) // Document ID
      .collection('reviews')
      .get(); // Subcollection name
  //print(app.docs.length);

  if (app.size == 0) {
    // No reviews, return a default value or handle accordingly
    controller.productRating.value = 0;
  }

  double sumRatings = 0.0;
  for (QueryDocumentSnapshot documentSnapshot in app.docs) {
    final Map<String, dynamic> data =
        documentSnapshot.data() as Map<String, dynamic>;
    final double rating = data['rating'] as double;
    sumRatings += rating;
    controller.productRating.value = sumRatings / app.size;
  }

  return app.docs.map((e) => UserRatingModel.fromMap(e.data())).toList();
}

// check promocode
Future getDiscountCode(String code) async {
  return await FirebaseFirestore.instance
      .collection('discount_code')
      .where("code", isEqualTo: code)
      .get()
      .then((docs) {
    if (docs.docs.isEmpty) {
      return null;
    }
    return docs.docs.first.data();
  });
}

// compelte order
Future<bool> compelteOrder(OrderModel order) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('orders')
        .add(order.toMap());
    controller.totalPrice.value = 0;
    controller.discount.value = 0;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
      controller.totalPrice.value = 0;
      controller.discount.value = 0;
    });

    return true;
  } on Exception {
    return false;
  }
}
