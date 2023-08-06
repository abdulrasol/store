import 'package:get/get.dart';
import 'package:store/database/models/category_model.dart';
import 'package:store/database/models/prodect_model.dart';
import 'package:store/database/models/slider_model.dart';
import 'package:store/database/services/category.dart';
import 'package:store/database/services/general.dart';
import 'package:store/database/services/items.dart';

class Controller extends GetxController {
  RxList<ProdectModel> products = <ProdectModel>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<SlideModel> sliders = <SlideModel>[].obs;
  RxDouble totalPrice = 1.0.obs;

  @override
  void onInit() async {
    products.value = await getProductsList();
    categories.value = await getCategoriesList();
    sliders.value = await getSliders();
    super.onInit();
  }
}
