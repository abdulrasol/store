import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
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
  final controllerText = TextEditingController();
  final btnController = RoundedLoadingButtonController();
  final high = const SizedBox(height: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(
          context: context, withBackAction: true, showSearchIcon: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pageTitle('Order'),
            high,
            const Text(
              'Shipping Address',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            high,
            FutureBuilder<List<UserAdressModel>>(
                future: Auth.getUserAddressList(),
                builder:
                    (context, AsyncSnapshot<List<UserAdressModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    return Row(
                      children: [
                        DropdownMenu<UserAdressModel>(
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
                        TextButton.icon(
                          icon: const Icon(Icons.add_location_alt_sharp),
                          onPressed: () {
                            Get.to(() => const UserAddressList())
                                ?.then((value) {
                              setState(() {});
                            });
                          },
                          label: const Text('add address'),
                        ),
                      ],
                    );
                  } else {
                    return const Text('Check your Internet');
                  }
                }),
            high,
            const Divider(),
            const Text(
              'Promocode',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            high,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controllerText,
                  ),
                ),
                const SizedBox(width: 25),
                RoundedLoadingButton(
                  width: 150,
                  controller: btnController,
                  onPressed: (() {}),
                  child: const Row(
                    children: [
                      Text('Apply'),
                      SizedBox(width: 15),
                      Icon(Iconsax.information),
                    ],
                  ),
                ),
                Expanded(child: high),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (controller.user.value != null) {
          } else {
            Get.to(() => const AuthPage());
          }
        },
        label: const Text('Order'),
        backgroundColor: Colors.black87,
        focusColor: Colors.black54,
        hoverColor: Colors.black54,
        //tooltip: 'Compelete order',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
