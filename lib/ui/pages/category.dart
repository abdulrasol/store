import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store/database/services/category.dart';
import 'package:store/database/models/category_model.dart';
import 'package:store/ui/widgets/product_card.dart';
import '../../database/models/prodect_model.dart';
import '../widgets/generic_app_bar.dart';

class CategoryPage extends StatelessWidget {
  final CategoryModel category;
  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(
        title: category.name,
        withBackAction: true,
        showSearchIcon: true,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Center(
              child: FutureBuilder<QuerySnapshot>(
                  future: getCategoryProducts(category: category.name),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ProdectModel> products =
                          snapshot.data!.docs.map((doc) {
                        return ProdectModel.fromMap(
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
                        children: products
                            .map((product) => ProductCart(product: product))
                            .toList(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
