import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/database/services/controller.dart';
import 'package:store/ui/pages/product.dart';

class Search extends SearchDelegate {
  final controller = Get.put(Controller());
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(CupertinoIcons.clear),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(CupertinoIcons.search),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(CupertinoIcons.back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(
        children: controller.products
            .where((item) => item.name.contains(query))
            .map((product) => InkWell(
                  onTap: () {
                    Get.to(() => ProductPage(product: product));
                  },
                  child: ListTile(
                    title: Text(product.name),
                  ),
                ))
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
        children: controller.products
            .where((item) => item.name.contains(query))
            .map((product) => InkWell(
                  onTap: () {
                    Get.to(() => ProductPage(product: product));
                  },
                  child: ListTile(
                    title: Text(product.name),
                  ),
                ))
            .toList());
  }
}
