import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/database/services/controller.dart';
import 'small_widget.dart';

class SettingsSectionWidgetCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget newPage;
  final double buttonBorder;
  final bool loginRequired;
  final Controller controller;
  const SettingsSectionWidgetCard({
    super.key,
    required this.icon,
    required this.title,
    required this.newPage,
    required this.buttonBorder,
    required this.loginRequired,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white12,
      ),
      child: ListTile(
        iconColor: Colors.black87,
        textColor: Colors.black87,
        leading: Icon(
          icon,
          size: 30,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        trailing: const Icon(
          CupertinoIcons.forward,
          size: 30,
        ),
        onTap: () {
          if (loginRequired) {
            if (controller.user.value == null) {
              logingCheckingSnakBar;
            } else {
              Get.to(() => newPage);
            }
          } else {
            Get.to(() => newPage);
          }
        },
      ),
    );
  }
}
