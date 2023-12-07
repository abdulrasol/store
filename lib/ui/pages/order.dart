import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:store/database/models/item_card.dart';
import 'package:store/database/models/user_adress_model.dart';
import 'package:store/database/services/auth.dart';
import 'package:store/database/services/controller.dart';
import 'package:store/database/services/items.dart';
import 'package:store/ui/pages/auth_page.dart';
import 'package:store/ui/pages/user_adress_list.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';
import 'package:store/ui/widgets/page_title.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final controller = Get.put(Controller());
  final controllerText = TextEditingController();
  final btnController = RoundedLoadingButtonController();
  final high = const SizedBox(height: 15);
  late UserAdressModel shoppingAdress;
  late double totalPrice;

  final dataCell = DataCell(
    Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.white,
      child: Container(
        color: Colors.grey[200],
        width: 50,
        height: 20,
      ),
    ),
  );

  DataRow getEmptyDataRow() => DataRow(cells: [dataCell, dataCell, dataCell]);

  @override
  Widget build(BuildContext context) {
    totalPrice = controller.totalPrice.value;
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
              pageTitle('Order Confirmation'),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (controller.user.value != null) {
            // Handle the order completion logic here
          } else {
            Get.to(() => const AuthPage());
          }
        },
        label: const Text('Confirm order'),
        backgroundColor: Colors.black87,
        focusColor: Colors.black54,
        hoverColor: Colors.black54,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildAddressSection() {
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
          FutureBuilder<List<UserAdressModel>>(
            future: Auth.getUserAddressList(),
            builder: (context, AsyncSnapshot<List<UserAdressModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No addresses available');
              } else {
                controller.userAdressModel.value = snapshot.data![0];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => DropdownButton<UserAdressModel>(
                        isExpanded: true,
                        value: controller.userAdressModel.value,
                        items: snapshot.data!
                            .map(
                              (e) => DropdownMenuItem<UserAdressModel>(
                                value: e,
                                child: Text(e.title),
                              ),
                            )
                            .toList(),
                        onChanged: (address) {
                          if (address != null) {
                            controller.userAdressModel.value = address;
                          }
                        },
                      ),
                    ),
                    /*
                    DropdownMenu<UserAdressModel>(
                      width: 320,
                      initialSelection: snapshot.data![0],
                      dropdownMenuEntries: snapshot.data!
                          .map(
                            (e) => DropdownMenuEntry<UserAdressModel>(
                              value: e,
                              label: e.title,
                              leadingIcon: const Icon(Icons.location_on_sharp),
                            ),
                          )
                          .toList(),
                    ),
                    */
                    const SizedBox(height: 10),
                    TextButton.icon(
                      icon: const Icon(
                        Icons.add_location_alt_sharp,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        Get.to(() => const UserAddressList())?.then((value) {
                          setState(() {});
                        });
                      },
                      label: const Text(
                        'add/edit address',
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget buildPricesSection() {
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
                  const Text('Items Prices: '),
                  const Expanded(child: SizedBox()),
                  Obx(() => Text(controller.totalPrice.toStringAsFixed(2))),
                ],
              ),
              high,
              const Row(
                children: [
                  Text('Shipping Price: '),
                  Expanded(child: SizedBox()),
                  Text('2'),
                ],
              ),
              high,
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: TextFormField(
                      controller: controllerText,
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(child: high),
                  RoundedLoadingButton(
                    color: Colors.black87,
                    width: 75,
                    controller: btnController,
                    onPressed: () async {
                      controller.discount.value = 2;
                      await Future.delayed(const Duration(seconds: 1));
                      btnController.success();
                    },
                    child: const Text('Apply'),
                  ),
                ],
              ),
              high,
              Row(
                children: [
                  const Text('Discount: '),
                  const Expanded(child: SizedBox()),
                  Obx(() => Text(controller.discount.value.toStringAsFixed(2))),
                ],
              ),
              high,
              const Divider(
                thickness: 1,
                color: Colors.black12,
              ),
              high,
              Row(
                children: [
                  const Text('Total Price: '),
                  const Expanded(child: SizedBox()),
                  Obx(() => Text((totalPrice - controller.discount.value)
                      .toStringAsFixed(2))),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildPaymentMethodSection() {
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
          DropdownButton<int>(
            isExpanded: true,
            items: const [
              DropdownMenuItem(
                child: Text('Pay on Delivery'),
              ),
            ],
            onChanged: (i) {},
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget buildItemsInSection() {
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
            child: FutureBuilder<List<CartItemModel>>(
              future: getCartItems(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DataTable(
                    columns: const [
                      DataColumn(label: Text('Item')),
                      DataColumn(label: Text('Quantity')),
                      DataColumn(label: Text('Units')),
                    ],
                    rows: snapshot.data!
                        .map(
                          (item) => DataRow(cells: [
                            DataCell(Text(item.item.name)),
                            DataCell(Text(item.quantity.toString())),
                            DataCell(Text(item.item.sellUnit)),
                          ]),
                        )
                        .toList(),
                  );
                } else {
                  return DataTable(
                    columns: const [
                      DataColumn(label: Text('Item')),
                      DataColumn(label: Text('Quantity')),
                      DataColumn(label: Text('Units')),
                    ],
                    rows: List.generate(3, (_) => getEmptyDataRow()),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
