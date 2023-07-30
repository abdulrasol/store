import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store/database/services/items.dart';
import 'package:store/database/models/prodect_model.dart';
import 'package:store/ui/widgets/product_card.dart';

Widget homeSection(
  List items, {
  required String title,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 0, 5),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      SizedBox(
        height: 200,
        width: double.infinity,
        // futurebuilder that get products from cloud by items fetchs
        child: FutureBuilder<QuerySnapshot>(
            future: getProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ProdectModel> products = snapshot.data!.docs.map((doc) {
                  return ProdectModel.fromMap(
                      doc.data() as Map<String, dynamic>);
                }).toList();

                return ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    ProdectModel product = products[index];
                    return SizedBox(
                      child: ProductCart(
                        product: ProdectModel(
                          id: product.id,
                          name: product.name,
                          price: product.price,
                          category: product.category,
                          sellUnit: product.sellUnit,
                          quantity: product.quantity,
                          image: product.image,
                          note: product.note,
                          increaseAmount: product.increaseAmount,
                          availability: product.availability,
                          priority: product.priority,
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: productCartShimmer(),
                    );
                  },
                );
              }
            }),
      ),
    ],
  );
}
