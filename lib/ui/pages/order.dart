import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:store/database/models/item_card.dart';
import 'package:store/database/models/order_model.dart';
import 'package:store/database/models/user_adress_model.dart';
import 'package:store/database/services/auth.dart';
import 'package:store/database/services/controller.dart';
import 'package:store/database/services/items.dart';
import 'package:store/ui/pages/auth_page.dart';
import 'package:store/ui/pages/order_view.dart';
import 'package:store/ui/pages/user_adress_list.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';
import 'package:store/ui/widgets/page_title.dart';
import 'package:store/ui/widgets/small_widget.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final controller = Get.put(Controller());
  final controllerText = TextEditingController();
  final btnController = RoundedLoadingButtonController();
  final flaotBtnController = RoundedLoadingButtonController();
  final high = const SizedBox(height: 15);
  late UserAdressModel shoppingAdress;

  DataRow getEmptyDataRow() => DataRow(cells: [dataCell, dataCell, dataCell]);

  @override
  Widget build(BuildContext context) {
    controller.totalPrice.value =
        controller.itemsPrices.value + controller.shoppingPrice.value;
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
      floatingActionButton: RoundedLoadingButton(
        controller: flaotBtnController,
        onPressed: () async {
          OrderModel order;
          if (controller.user.value != null) {
            bool orderProcess = await compelteOrder(
              order = OrderModel(
                id: DateTime.now()
                    .millisecondsSinceEpoch
                    .toString()
                    .substring(5),
                items:
                    controller.cart.map((element) => element.toMap()).toList(),
                timestamp: DateTime.now().toIso8601String(),
                price: controller.totalPrice(),
                discount: controller.discount.value,
                state: 'processing',
                address: controller.userAdressModel.value.toMap(),
              ),
            );

            if (orderProcess) {
              Get.defaultDialog(
                backgroundColor: Colors.grey.shade300,
                title: 'Your order has been confirmed!',
                titlePadding: const EdgeInsets.all(15),
                //confirm: Icon(FontAwesome.truck),
                content: const Icon(
                  BoxIcons.bx_check_circle,
                  size: 50,
                ),
              ).then(
                (value) => Get.off(
                  () => OrderView(
                    order: order,
                  ),
                ),
              );
            }
          } else {
            Get.to(() => const AuthPage());
          }
        },
        color: Colors.black87,
        child: const Text('Confirm order'),
      ),
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
                  Text(controller.itemsPrices.toStringAsFixed(2)),
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
                      decoration:
                          const InputDecoration(label: Text('Discount code')),
                      controller: controllerText,
                      onChanged: ((value) {
                        if (controller.discount.value == 0) {
                          btnController.reset();
                        }
                      }),
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(child: high),
                  RoundedLoadingButton(
                    color: Colors.black87,
                    width: 75,
                    controller: btnController,
                    onPressed: () async {
                      var code = await getDiscountCode(controllerText.text);
                      if (code == null) {
                        btnController.error();
                        Get.defaultDialog(
                          backgroundColor: Colors.grey.shade300,
                          title: 'code doesn\'t macth!',
                          titlePadding: const EdgeInsets.all(15),
                          //confirm: Icon(FontAwesome.truck),
                          content: const Icon(
                            Bootstrap.x_circle,
                            size: 50,
                          ),
                        );
                      } else if (code['discount'] >
                          controller.totalPrice.value) {
                        btnController.stop();
                        Get.defaultDialog(
                          backgroundColor: Colors.grey.shade300,
                          title:
                              'Total price should be more than discount value!',
                          titlePadding: const EdgeInsets.all(15),
                          //confirm: Icon(FontAwesome.truck),
                          content: const Icon(
                            Bootstrap.info_circle_fill,
                            size: 50,
                          ),
                        );
                      } else {
                        if (code['use count'] <= code['limit']) {
                          btnController.success();
                          controller.discount.value = code['discount'];
                          controller.totalPrice.value -=
                              controller.discount.value;
                        }
                      }
                      //btnController.success();
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
                  Obx(() =>
                      Text((controller.totalPrice.value).toStringAsFixed(2))),
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
                  controller.cart.value = snapshot.data!;
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
