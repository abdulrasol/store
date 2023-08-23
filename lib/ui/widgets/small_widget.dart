import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/ui/pages/auth_page.dart';

void checkLoginandShowSnakBar() {
  Get.snackbar('Info', 'Login first please',
      icon: const Icon(
        CupertinoIcons.checkmark_circle_fill,
        color: Colors.blue,
      )).show();
}

var logingCheckingSnakBar = Get.showSnackbar(
  GetSnackBar(
    animationDuration: const Duration(milliseconds: 500),
    duration: const Duration(seconds: 2),
    message: 'Login first please',
    mainButton: TextButton(
      onPressed: () {
        Get.to(() => const AuthPage());
      },
      child: const Text('login'),
    ),
  ),
);
