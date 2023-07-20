import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/database/models/prodect_model.dart';
import '../widgets/generic_app_bar.dart';

class ItemPage extends StatelessWidget {
  final ProdectModel product;

  const ItemPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double quantity = product.increaseAmount;
    return Scaffold(
      appBar: genericAppBar(
        title: product.name,
        withBackAction: true,
        showSearchIcon: false,
        centerTitle: true,
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: Image.memory(base64.decode(
                              product.image)) //Image.network(item.image),
                          ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          sizedBox,
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${product.price}\$',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'per ${product.sellUnit}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700]!,
                                  ),
                                )
                              ],
                            ),
                          ),
                          sizedBox,
                          //UpdateCount(item: item, quantity: quantity),
                          sizedBox,
                          Text(
                            product.note,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 70),
                    ],
                  ),
                )),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black87,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: 'Total Price '),
                            TextSpan(
                                text:
                                    '${(product.price * quantity).toStringAsFixed(2)}\$')
                          ],
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Expanded(child: sizedBox),
                      TextButton.icon(
                        onPressed: () async {
                          /*  await _controller.addItemToCart(
                              item: item, quantity: quantity);
                          quantity = 1; */
                          /*  showSnackbar(
                            'Cart',
                            '${item.name} added to cart',
                            item.image,
                            mainButton: TextButton(
                              onPressed: () => Get.to(() => Cart()),
                              child: const Text('View Cart'),
                            ),
                          ); */
                        },
                        label: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        icon: const Icon(
                          CupertinoIcons.cart,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ), /* Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
            child: Image.asset('assets/imgs/item2.png'),
          ),
          const SizedBox(width: 20),

        ],
      ),*/
    );
  }
}
