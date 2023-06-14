import 'package:flutter/material.dart';

import '../../database/models/category_model.dart';
import 'category_card.dart';

Column categoriesWrap() {
  return Column(
    children: [
      const Padding(
        padding: EdgeInsets.fromLTRB(5, 20, 0, 5),
        child: Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
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
              CategoryCard(
                category:
                    CategoryModel('Cat 01', 'assets/imgs/banner1.jpg', ''),
              ),
              CategoryCard(
                category:
                    CategoryModel('Cat 01', 'assets/imgs/banner1.jpg', ''),
              ),
              CategoryCard(
                category:
                    CategoryModel('Cat 01', 'assets/imgs/banner1.jpg', ''),
              ),
              CategoryCard(
                category:
                    CategoryModel('Cat 01', 'assets/imgs/banner1.jpg', ''),
              ),
              CategoryCard(
                category:
                    CategoryModel('Cat 01', 'assets/imgs/banner1.jpg', ''),
              ),
              CategoryCard(
                category:
                    CategoryModel('Cat 01', 'assets/imgs/banner1.jpg', ''),
              ),
              CategoryCard(
                category:
                    CategoryModel('Cat 01', 'assets/imgs/banner1.jpg', ''),
              ),
              CategoryCard(
                category:
                    CategoryModel('Cat 01', 'assets/imgs/banner1.jpg', ''),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
