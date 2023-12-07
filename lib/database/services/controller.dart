import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:store/database/models/category_model.dart';
import 'package:store/database/models/item_card.dart';
import 'package:store/database/models/prodect_model.dart';
import 'package:store/database/models/slider_model.dart';
import 'package:store/database/models/user_adress_model.dart';
import 'package:store/database/models/user_model.dart';
import 'package:store/database/services/category.dart';
import 'package:store/database/services/general.dart';
import 'package:store/database/services/items.dart';

class Controller extends GetxController {
  RxList<ProdectModel> products = <ProdectModel>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<CartItemModel> cart = <CartItemModel>[].obs;
  RxList<SlideModel> sliders = <SlideModel>[].obs;
  RxDouble totalPrice = 1.0.obs;
  RxDouble discount = 0.0.obs;
  RxDouble productRating = 0.0.obs;
  Rx<User?> user = Rx<User?>(null);
  Rx<UserModel> userData = Rx<UserModel>(UserModel(profileImage: ''));
  Rx<UserAdressModel> userAdressModel = Rx<UserAdressModel>(UserAdressModel(
      id: '', title: '', description: '', latitude: 1, longitude: 1));

  Future<void> updateUserData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.value!.uid)
        .get()
        .then((data) {
      userData.value = UserModel(profileImage: data.data()?['profileImage']);
    });
  }

  @override
  void onInit() async {
    // get products, categories and Sliders List
    products.value = await getProductsList();
    categories.value = await getCategoriesList();
    sliders.value = await getSliders();

    // Listen to the authStateChanges stream and update the user stream
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      this.user.value = user;
      if (user != null) {
        updateUserData();
      }
    });
    super.onInit();
  }
}
