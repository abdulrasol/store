import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/database/services/controller.dart';
import 'category_card.dart';

Column categoriesWrap({bool withTitle = true}) {
  final Controller controller = Get.put(Controller());
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
          child: Obx(() {
            if (controller.categories.isNotEmpty) {
              return Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runAlignment: WrapAlignment.start,
                  alignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  runSpacing: 5,
                  spacing: 5,
                  children: controller.categories
                      .map((element) => CategoryCard(category: element))
                      .toList());
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
