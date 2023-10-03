import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/database/models/item_card.dart';

class CartItemWidget extends StatefulWidget {
  final CartItem item;
  const CartItemWidget({super.key, required this.item});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Card(
          margin: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(widget.item.item.image),
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
                        widget.item.price.toString(),
                        style: const TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.item.decreaseQuantity();
                        });
                      },
                      icon: const Icon(
                        CupertinoIcons.minus_square_fill,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.item.quantity.toString(),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.item.increaseQuantity();
                        });
                      },
                      icon: const Icon(
                        CupertinoIcons.plus_app_fill,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.delete,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
