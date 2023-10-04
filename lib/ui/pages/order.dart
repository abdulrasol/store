import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/database/models/user_adress_model.dart';
import 'package:store/database/services/auth.dart';
import 'package:store/database/services/controller.dart';
import 'package:store/ui/pages/auth_page.dart';
import 'package:store/ui/pages/user_adress_list.dart';
import 'package:store/ui/widgets/page_title.dart';

import '../widgets/generic_app_bar.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final controller = Get.put(Controller());

  var list = ['one', 'two', 'three'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(
          context: context, withBackAction: true, showSearchIcon: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<UserAdressModel>>(
            future: Auth.getUserAddressList(),
            builder: (context, AsyncSnapshot<List<UserAdressModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pageTitle('Order'),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    const Text(
                      'Shipping Address',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        DropdownMenu<UserAdressModel>(
                          //width: double.infinity,
                          initialSelection: snapshot.data![0],
                          dropdownMenuEntries: snapshot.data!
                              .map(
                                (e) => DropdownMenuEntry<UserAdressModel>(
                                    value: e,
                                    label: e.title,
                                    leadingIcon:
                                        const Icon(Icons.location_on_sharp)),
                              )
                              .toList(),
                        ),
                        const SizedBox(width: 15),
                        IconButton(
                          icon: const Icon(Icons.add_location_alt_sharp),
                          onPressed: () {
                            Get.to(() => const UserAddressList())
                                ?.then((value) {
                              setState(() {});
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Divider(),
                    const SizedBox(height: 15),
                    const Text(
                      'Promocode',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        TextFormField(),
                      ],
                    ),
                  ],
                );
              } else {
                return const Center();
              }
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (controller.user.value != null) {
          } else {
            Get.to(() => const AuthPage());
          }
        },
        label: Text(controller.user.value != null ? 'Order' : 'Login'),
        backgroundColor: Colors.black87,
        focusColor: Colors.black54,
        hoverColor: Colors.black54,
        //tooltip: 'Compelete order',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
