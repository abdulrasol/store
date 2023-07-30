import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store/database/services/category.dart';
import '../../database/models/category_model.dart';
import 'category_card.dart';

Column categoriesWrap({bool withTitle = true}) {
  return Column(
    children: [
      withTitle
          ? const Padding(
              padding: EdgeInsets.fromLTRB(5, 20, 0, 5),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )
          : const SizedBox(),
      SizedBox(
        width: double.infinity,
        child: Center(
          child: FutureBuilder<QuerySnapshot>(
              future: getCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<CategoryModel> categories =
                      snapshot.data!.docs.map((doc) {
                    return CategoryModel.fromMap(
                        doc.data() as Map<String, dynamic>);
                  }).toList();
                  return Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.start,
                    alignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    runSpacing: 5,
                    spacing: 5,
                    children: categories
                        .map((category) => CategoryCard(category: category))
                        .toList(),
                  );
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Wrap(
                    children: [
                      categoryCartShimmer(),
                      categoryCartShimmer(),
                      categoryCartShimmer(),
                      categoryCartShimmer(),
                      categoryCartShimmer(),
                    ],
                  );
                }
              }),
        ),
      ),
    ],
  );
}
