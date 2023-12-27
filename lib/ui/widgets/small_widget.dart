import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:shimmer/shimmer.dart';
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

void showloginRequiredAlert() {
  Get.defaultDialog(
    backgroundColor: Colors.grey.shade300,
    title: 'Login Required',
    titlePadding: const EdgeInsets.all(15),
    //confirm: Icon(FontAwesome.truck),
    content: const Icon(
      Bootstrap.person_exclamation,
      size: 50,
    ),
  );
}

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

Widget circularProgressIndicator() {
  return Center(
    child: SizedBox(
      width: 100,
      height: 100,
      child: LiquidCircularProgressIndicator(
        value: 0.7, // Defaults to 0.5.
        valueColor: const AlwaysStoppedAnimation(
            Colors.black45), // Defaults to the current Theme's accentColor.
        backgroundColor:
            Colors.white, // Defaults to the current Theme's backgroundColor.
        borderColor: Colors.black87,
        borderWidth: 5.0,
        direction: Axis
            .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
        center: const Text(
          "Loading...",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
