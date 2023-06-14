import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final String name;
  final double price;
  final String image;
  const Item(
      {super.key,
      required this.name,
      required this.price,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      child: SizedBox(
        width: 25,
        child: Column(
          children: [
            Expanded(
              child: Image.asset(''),
            ),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
