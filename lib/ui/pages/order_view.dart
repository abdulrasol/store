import 'package:flutter/material.dart';

import 'package:store/database/models/order_model.dart';

import 'package:store/ui/widgets/generic_app_bar.dart';
import 'package:store/ui/widgets/page_title.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key, required this.order});
  final high = const SizedBox(height: 15);
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(
        context: context,
        withBackAction: true,
        showSearchIcon: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              pageTitle('Order 00123'),
              const SizedBox(height: 30),
              Wrap(
                runSpacing: 25,
                spacing: 25,
                direction: Axis.horizontal,
                children: [
                  buildAddressSection(),
                  buildPricesSection(),
                  buildPaymentMethodSection(),
                  buildItemsInSection(),
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  buildAddressSection() {
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shipping Address',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          high,
          Text(order.address['title']),
          const Divider(),
        ],
      ),
    );
  }

  buildPricesSection() {
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Prices',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          Column(
            children: [
              high,
              Row(
                children: [
                  const Text('Order Price: '),
                  const Expanded(child: SizedBox()),
                  Text(
                    order.price.toStringAsFixed(2),
                  ),
                ],
              ),
              high,
              const Row(
                children: [
                  Text('Shipping Price: '),
                  Expanded(child: SizedBox()),
                  Text('2\$'),
                ],
              ),
              high,
              Row(
                children: [
                  const Text('Discount: '),
                  const Expanded(child: SizedBox()),
                  Text('0'),
                ],
              ),
              high,
              const Divider(
                thickness: 1,
                color: Colors.black12,
              ),
            ],
          )
        ],
      ),
    );
  }

  buildPaymentMethodSection() {
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment method',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          high,
          const Text('Pay on Delivery'),
          const Divider(),
        ],
      ),
    );
  }

  buildItemsInSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Items in Order',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        high,
        Container(
          width: 320,
          constraints: const BoxConstraints(
            maxHeight: 400, // Set your maximum height here
          ),
          child: SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Item')),
                DataColumn(label: Text('Quantity')),
                DataColumn(label: Text('Units')),
              ],
              rows: order.items
                  .map(
                    (item) => DataRow(cells: [
                      DataCell(Text(item['item']['name'])),
                      DataCell(Text(item['quantity'].toString())),
                      DataCell(Text(item['item']['sellUnit'])),
                    ]),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
