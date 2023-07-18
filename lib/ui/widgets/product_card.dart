import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/database/models/item_model.dart';
import 'package:store/ui/pages/item.dart';

class ProductCart extends StatelessWidget {
  final ItemModel item;
  const ProductCart({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
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
