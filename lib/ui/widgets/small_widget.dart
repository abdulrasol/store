import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/ui/pages/signup.dart';

void checkLoginandShowSnakBar() {}
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
