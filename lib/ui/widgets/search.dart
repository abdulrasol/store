import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/database/models/prodect_model.dart';
import 'package:store/database/services/items.dart';

class Search extends SearchDelegate {
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
    return FutureBuilder<QuerySnapshot>(
      future: getFilterdProducts(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return searchCardWidget(snapshot);
        }
        if (snapshot.hasError) {
          return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 2,
              margin: const EdgeInsets.all(5),
              child: const InkWell(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                ),
              ));
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Get the current text

    return FutureBuilder<QuerySnapshot>(
      future: getFilterdProducts(query),
      builder: (context, snapshot) {
        // print(snapshot.data!.docs.length);
        //print(query);
        if (snapshot.hasData) {
          return searchCardWidget(snapshot);
        }
        if (snapshot.hasError) {
          return ListView(
              children: snapshot.data!.docs.map((doc) {
            // Create a product card from the document
            ProdectModel product =
                ProdectModel.fromMap(doc.data() as Map<String, dynamic>);

            // Return the product card
            return ListTile(
              title: Text(product.name),
            );
          }).toList());
          /* Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 2,
              margin: const EdgeInsets.all(5),
              child: const InkWell(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                ),
              )); */
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  ListView searchCardWidget(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              width: 1,
              color: Colors.grey[300]!,
            ),
          ),
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 2.5),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                SizedBox(
                    width: 50, child: Image.asset('assets/imgs/item2.png')),
                const SizedBox(width: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Item name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '5\$', // '${_controller.query.value.getSearchedItems(query)[index].price}\$ for ${_controller.query.value.getSearchedItems(query)[index].sellUnit}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );

        /* Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 2,
              margin: const EdgeInsets.all(5),
              child: const InkWell(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                ),
              ));
         */
      },
    );
  }
}
