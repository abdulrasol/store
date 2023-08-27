import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:store/database/models/category_model.dart';
import 'package:store/database/models/prodect_model.dart';
import 'package:store/database/models/slider_model.dart';
import 'package:store/database/models/user_model.dart';
import 'package:store/database/services/auth.dart';
import 'package:store/database/services/category.dart';
import 'package:store/database/services/general.dart';
import 'package:store/database/services/items.dart';

class Controller extends GetxController {
  RxList<ProdectModel> products = <ProdectModel>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<SlideModel> sliders = <SlideModel>[].obs;
  RxDouble totalPrice = 1.0.obs;
  Rx<User?> user = Rx<User?>(null);
  Rx<UserModel> userData = Rx<UserModel>(UserModel(profileImage: ''));

  @override
  void onInit() async {
    // get products, categories and Sliders List
    products.value = await getProductsList();
    categories.value = await getCategoriesList();
    sliders.value = await getSliders();

    // Listen to the authStateChanges stream and update the user stream
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      this.user.value = user;
    });
    if (user.value != null) {
      userData.value = await Auth.getUserData();
    }
    super.onInit();
  }
}
