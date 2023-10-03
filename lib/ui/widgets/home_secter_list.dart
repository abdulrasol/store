import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/database/models/prodect_model.dart';
import 'package:store/ui/widgets/product_card.dart';
import '../../database/services/controller.dart';

Widget homeSectionList(
  List items, {
  required String title,
}) {
  final Controller controller = Get.put(Controller());
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 0, 5),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      SizedBox(
        height: 205,
        width: double.infinity,
        // futurebuilder that get products from cloud by items fetchs
        child: Obx(
          () {
            if (controller.products.isEmpty) {
              return ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    child: productCartShimmer(),
                  );
                },
              );
            } else {
              return ListView.builder(
                itemCount: controller.products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  ProdectModel product = controller.products[index];
                  return SizedBox(
                    child: ProductCart(
                      product: ProdectModel(
                        id: product.id,
                        name: product.name,
                        price: product.price,
                        category: product.category,
                        sellUnit: product.sellUnit,
                        quantity: product.quantity,
                        image: product.image,
                        description: product.description,
                        increaseAmount: product.increaseAmount,
                        availability: product.availability,
                        priority: product.priority,
                      ),
                    ),
                  );
                },
              );
            }
            // print(controller.products.length);
          },
        ),
      ),
    ],
  );
}
