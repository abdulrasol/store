import 'package:flutter/material.dart';

import '../../database/models/item_model.dart';
import '../widgets/generic_app_bar.dart';
import '../widgets/item_card.dart';

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
                  ItemCard(
                    item: ItemModel('Item 1', 10, 'dd', 1, 1,
                        'assets/imgs/item2.png', 'description'),
                  ),
                  ItemCard(
                    item: ItemModel('Item 1', 10, 'dd', 1, 1,
                        'assets/imgs/item2.png', 'description'),
                  ),
                  ItemCard(
                    item: ItemModel('Item 1', 10, 'dd', 1, 1,
                        'assets/imgs/item2.png', 'description'),
                  ),
                  ItemCard(
                    item: ItemModel('Item 1', 10, 'dd', 1, 1,
                        'assets/imgs/item2.png', 'description'),
                  ),
                  ItemCard(
                    item: ItemModel('Item 1', 10, 'dd', 1, 1,
                        'assets/imgs/item2.png', 'description'),
                  ),
                  ItemCard(
                    item: ItemModel('Item 1', 10, 'dd', 1, 1,
                        'assets/imgs/item2.png', 'description'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
