import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/generic_app_bar.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(
        title: 'My Orders',
        withBackAction: true,
        showSearchIcon: false,
        centerTitle: true,
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
                          child: Image.asset(
                              'assets/imgs/item2.png') //Image.network(item.image),
                          ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Item Title",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          sizedBox,
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: '45\$', //'${item.price}\$',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'per one kilo}', //'per ${item.sellUnit}',
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
                          const Text(
                            'لا الخدع أسبرناتور طريق وذلك. هو شيء قال أو نقود. لذلك سهل مدمر الأكثر الحمدون أبداً. أقل شخص يهرب المرونة آتي سهل عقل المحدد خطأ آتي. فليكن أسبرناتور قيمة اللطف آلام يهرب لو شئ مرات بالفعل.',
                            //item.note,
                            style: TextStyle(
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
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'Total Price '),
                            TextSpan(text: '34'
                                // '${(item.price * quantity).toStringAsFixed(2)}\$')
                                )
                          ],
                        ),
                        style: TextStyle(
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
