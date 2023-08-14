import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black87),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        elevation: MaterialStateProperty.all(2),
                        minimumSize:
                            MaterialStateProperty.all(const Size(35, 35)),
                        maximumSize:
                            MaterialStateProperty.all(const Size(35, 35)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                      ),
                      onPressed: () async {
                        if (controller.user.value == null) {
                          logingCheckingSnakBar;
                        }
                        var adding = await addCartToCart(CartItemModel(
                            item: product, quantity: product.increaseAmount));
                        if (adding == null) {
                          Get.snackbar(
                              'success', 'product added to cart successfully',
                              icon: const Icon(
                                CupertinoIcons.checkmark_circle_fill,
                                color: Colors.blue,
                              )).show();
                        } else {
                          Get.snackbar('failed', 'failed to add item to cart ',
                              icon: Icon(
                                CupertinoIcons.xmark_circle_fill,
                                color: Colors.red.shade300,
                              )).show();
                        }
                      },
                      child: const Center(child: Icon(CupertinoIcons.plus)),
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
