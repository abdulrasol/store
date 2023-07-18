import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/database/models/item_model.dart';
import 'package:store/ui/pages/item.dart';

import 'generic_app_bar.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;
  const ItemCard({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey[300]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      margin: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Get.to(() => const ItemPage());
        },
        child: SizedBox(
          // height: 260,
          width: 150,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 134,
                  // height: 100,
                  child: SizedBox(
                    width: 100,
                    child: Image.asset(
                      item.image,
                      fit: BoxFit.cover,
                    ), // Image.network(item.image), //Image.memory(base64Decode(item.image)),
                  ),
                ),
                sizedBox,
                Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  '\$${item.price}/${item.unit}',
                  style: const TextStyle(color: Colors.black38),
                ),
                sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.price.toString()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        // backgroundColor: MaterialStateProperty.all(color),
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
                      onPressed: () async {
                        /*showSnackbar(
                          'Cart',
                          '${item.name} added to cart',
                          item.image,
                          mainButton: TextButton(
                            onPressed: () {/* Get.to(() => Cart()) */},
                            child: const Text('View Cart'),
                          ),
                        );*/
                      },
                      child: const Center(child: Icon(CupertinoIcons.plus)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
