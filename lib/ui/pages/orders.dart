import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/database/models/order_model.dart';
import 'package:store/database/services/items.dart';
import 'package:store/ui/pages/order_view.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';
import 'package:store/ui/widgets/small_widget.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    const sizebox = SizedBox(height: 8);
    Widget orderCard({
      required String orderNumer,
      required int quantity,
      required date,
      required String state,
      required double price,
      required OrderModel order,
    }) {
      return Card(
        elevation: 1,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: InkWell(
          onTap: (() {
            Get.to(() => OrderView(order: order));
          }),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Order Number: $orderNumer'),
                    Text('$quantity Product'),
                    Text(date),
                  ],
                ),
                const Divider(),
                sizebox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Price: ${price.toStringAsFixed(2)}\$'),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black87,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          state,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: genericAppBar(
        title: 'My Orders',
        withBackAction: true,
        centerTitle: true,
        showSearchIcon: false,
        context: context,
      ),
      body: FutureBuilder<List<OrderModel>>(
          future: getOrders(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: ((context, index) => orderCard(
                        order: snapshot.data![index],
                        orderNumer: snapshot.data![index].id,
                        quantity: snapshot.data![index].items.length,
                        date: snapshot.data![index].timestamp.split('T')[0],
                        state: snapshot.data![index].state,
                        price: snapshot.data![index].price,
                      )));
            } else {
              return circularProgressIndicator();
            }
          })),
    );
  }
}
