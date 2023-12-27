import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:store/database/models/item_card.dart';
import 'package:store/database/services/controller.dart';
import 'package:store/database/services/items.dart';
import 'package:store/ui/pages/order.dart';
import 'package:store/ui/widgets/cart_item_widget.dart';
import 'package:store/ui/widgets/page_title.dart';
import 'package:store/ui/widgets/small_widget.dart';

import '../widgets/generic_app_bar.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final controller = Get.put(Controller());
  var isCartEmpty = false;
  int? updateView() {
    setState(() {});
    return null;
  }

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
                : Expanded(
                    child: StreamBuilder<List<CartItemModel>>(
                      stream: cartItemsStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return circularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Placeholder();
                        } else if (snapshot.hasData) {
                          final cartItems = snapshot.data!;
                          if (cartItems.isEmpty) {
                            isCartEmpty = true;
                            return const Center(
                              child: Text('No items in the cart.'),
                            );
                          }
                          return ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = cartItems[index];
                              return CartItemWidget(
                                item: item,
                                updateView: updateView,
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: Text('No data available.'),
                          );
                        }
                      },
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (controller.user.value != null) {
            if (isCartEmpty) {
              Get.defaultDialog(
                backgroundColor: Colors.grey.shade300,
                title: 'Your cart is empty!',
                titlePadding: const EdgeInsets.all(15),
                //confirm: Icon(FontAwesome.truck),
                content: const Icon(
                  Bootstrap.exclamation_circle,
                  size: 50,
                ),
              );
            } else {
              await calculateItemsPrice();
              Get.to(() => const Order());
            }
          }
        },
        label: Obx(
          () => Text(
              controller.user.value != null ? 'Order' : 'Shuold login first!'),
        ),
        backgroundColor: Colors.black87,
        focusColor: Colors.black54,
        hoverColor: Colors.black54,
        //tooltip: 'Compelete order',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
