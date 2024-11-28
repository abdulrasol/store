import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:store/database/models/prodect_model.dart';
import 'package:store/ui/pages/product.dart';
import '../../database/models/item_card.dart';
import '../../database/services/controller.dart';
import '../../database/services/items.dart';
import 'small_widget.dart';

class ProductCart extends StatelessWidget {
  final ProdectModel product;
  const ProductCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    final btnController = RoundedLoadingButtonController();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 2,
      margin: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Get.to(() => ProductPage(product: product));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 120,
            height: 190,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                  child: Center(
                    child: Image.memory(
                      base64.decode(product.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${product.price}\$",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          //  textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          product.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    RoundedLoadingButton(
                      width: 45,
                      height: 38,
                      borderRadius: 45,
                      elevation: 2,
                      color: Colors.white,
                      valueColor: Colors.black87,
                      controller: btnController,
                      onPressed: () async {
                        if (controller.user.value == null) {}
                        var adding = await addCartToCart(
                          CartItemModel(
                              item: product,
                              quantity: product.increaseAmount,
                              id: ''),
                        );
                        if (adding == null) {
                          btnController.success();
                        } else {
                          btnController.error();
                          showloginRequiredAlert();
                        }
                      },
                      child: const Center(
                        child: Icon(
                          Bootstrap.cart_plus,
                          color: Colors.black87,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// shimor
Widget productCartShimmer() {
  return Card(
    child: SizedBox(
      width: 146,
      height: 190,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 134,
                height: 120,
                child: CircleAvatar(
                  radius: double.infinity,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.grey[200],
                        height: 10,
                        width: 40,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        color: Colors.grey[200],
                        height: 10,
                        width: 70,
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.grey[200],
                    height: 40,
                    width: 40,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
