<<<<<<< HEAD
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/database/models/item_model.dart';
import 'package:store/ui/pages/item.dart';
=======
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:store/database/models/prodect_model.dart';
import 'package:store/ui/pages/product.dart';
import '../../database/models/item_card.dart';
import '../../database/services/controller.dart';
import '../../database/services/items.dart';
import 'small_widget.dart';
>>>>>>> e560d9cfa98b7491bceb3b441c498f148bf6b137

class ProductCart extends StatelessWidget {
  final ItemModel item;
  const ProductCart({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
=======
    final controller = Get.put(Controller());
    final btnController = RoundedLoadingButtonController();

>>>>>>> e560d9cfa98b7491bceb3b441c498f148bf6b137
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 2,
      margin: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Get.to(() => const ItemPage());
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                  child: Center(
                    child: Image.asset(
                      item.image,
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
                          "${item.price}\$",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          //  textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
<<<<<<< HEAD
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black87),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        elevation: MaterialStateProperty.all(2),
                        minimumSize:
                            MaterialStateProperty.all(const Size(40, 40)),
                        maximumSize:
                            MaterialStateProperty.all(const Size(40, 40)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                      ),
                      onPressed: () {},
                      child: const Center(child: Icon(CupertinoIcons.plus)),
=======
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
>>>>>>> e560d9cfa98b7491bceb3b441c498f148bf6b137
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
