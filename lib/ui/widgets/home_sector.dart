import 'package:flutter/material.dart';
import 'package:store/database/models/item_model.dart';
import 'package:store/ui/widgets/item_card.dart';
import 'package:store/ui/widgets/product_card.dart';

Widget homeSection(
  List items, {
  required String title,
}) {
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
        height: 200,
        width: double.infinity,
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SizedBox(
              child: ProductCart(
                item: ItemModel('Item 1', 10, 'dd', 1, 1,
                    'assets/imgs/item2.png', 'description'),
              ),
            );
          },
        ),
      ),
    ],
  );
}
