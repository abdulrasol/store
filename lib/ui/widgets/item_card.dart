import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/database/models/item_model.dart';
import 'package:store/ui/pages/item.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;
  const ItemCard({super.key, required this.item});

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
          Get.to(const ItemPage());
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
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
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      //color: Colors.white10,
                    ),
                    //color: Colors.black87,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
