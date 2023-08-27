import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:store/ui/pages/auth_page.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';

class LoginWidget extends StatelessWidget {
  final String message;
  final controller = RoundedLoadingButtonController();
  LoginWidget(
      {super.key, this.message = 'Please login first to open this page!'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(message),
        sizedBox,
        RoundedLoadingButton(
          color: Colors.black87,
          onPressed: () async {
            await Get.to(() => const AuthPage())
                ?.then((value) => controller.success());
          },
          controller: controller,
          child: const Text('Login Here'),
        )
      ]),
    );
  }
}
