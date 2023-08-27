import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:store/database/models/item_card.dart';
import 'package:store/database/services/items.dart';

class CartItemWidget extends StatefulWidget {
  final CartItemModel item;
  final void Function() updateView;

  const CartItemWidget(
      {super.key, required this.item, required this.updateView});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  final btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: Card(
          margin: const EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.memory(base64Decode(widget.item.item.image)),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.item.name,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          '${widget.item.item.price.toString()} \$ per ${widget.item.item.sellUnit}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          'total price: ${widget.item.price.toStringAsFixed(2)}\$ for ${widget.item.quantity} ${widget.item.item.sellUnit}',
                          style: const TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: RoundedLoadingButton(
                    elevation: 0,
                    color: Colors.white,
                    valueColor: Colors.black87,
                    width: 50,
                    controller: btnController,
                    onPressed: () async {
                      await deleteCartItem(widget.item.id)
                          .then((value) => btnController.reset());
                    },
                    child: const Icon(
                      Bootstrap.x_circle_fill,
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
