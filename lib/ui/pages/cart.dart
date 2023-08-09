import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/database/models/item_card.dart';
import 'package:store/database/models/prodect_model.dart';
import 'package:store/database/services/controller.dart';
import 'package:store/ui/pages/auth_page.dart';
import 'package:store/ui/widgets/cart_item_widget.dart';
import 'package:store/ui/widgets/page_title.dart';

import '../widgets/generic_app_bar.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final controller = Get.put(Controller());
  final CartItem item = CartItem(
    ProdectModel(
      id: 'id',
      name: 'name',
      price: 12,
      category: 'category',
      sellUnit: 'sellUnit',
      quantity: 1,
      image: 'assets/imgs/item2.png',
      note: 'description',
      increaseAmount: 1,
      availability: true,
      priority: 1,
    ),
    2,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(context: context),
      body: Column(
        children: [
          pageTitle('Cart'),
          const SizedBox(height: 20),
          Obx(
            () => controller.user.value == null
                ? const Center(
                    child: Column(
                      children: [
                        Text('Please Login First to show your cart items')
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        CartItemWidget(item: item),
                      ],
                    ),
                  ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (controller.user.value != null) {
          } else {
            Get.to(() => const AuthPage());
          }
        },
        label: Text(controller.user.value != null ? 'Order' : 'Login'),
        backgroundColor: Colors.black87,
        focusColor: Colors.black54,
        hoverColor: Colors.black54,
        //tooltip: 'Compelete order',
      ),
    );
  }
}
