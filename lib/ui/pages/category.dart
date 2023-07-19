import 'package:flutter/material.dart';
import 'package:store/ui/widgets/product_card.dart';
import '../../database/models/item_model.dart';
import '../widgets/generic_app_bar.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(
        title: 'Category Name',
        withBackAction: true,
        showSearchIcon: true,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                alignment: WrapAlignment.start,
                verticalDirection: VerticalDirection.down,
                runSpacing: 5,
                spacing: 5,
                children: [
                  ProductCart(
                      item: ItemModel('name', 2, 'category', 1, 2,
                          'assets/imgs/item01.jpeg', 'description')),
                  ProductCart(
                      item: ItemModel('name', 2, 'category', 1, 2,
                          'assets/imgs/item2.png', 'description')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
