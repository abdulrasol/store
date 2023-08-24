import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/database/models/item_card.dart';
import 'package:store/database/services/items.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel item;
  final void Function() updateView;

  const CartItemWidget(
      {super.key, required this.item, required this.updateView});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Card(
          margin: const EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.memory(base64Decode(item.item.image)),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.item.name,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          '${item.item.price.toString()} \$ per ${item.item.sellUnit}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          'total price: ${item.price.toStringAsFixed(2)}\$ for ${item.quantity} ${item.item.sellUnit}',
                          style: const TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: IconButton(
                    onPressed: () async {
                      await deleteCartItem(item.id);
                      updateView(); // Pass an integer argument here, for example: 42
                    },
                    icon: const Icon(
                      CupertinoIcons.delete,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
