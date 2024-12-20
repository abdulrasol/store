import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/ui/widgets/search.dart';

AppBar genericAppBar({
  String title = '',
  bool withBackAction = false,
  bool centerTitle = false,
  bool showSearchIcon = true,
  required BuildContext context,
}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(color: Colors.black87),
    ),
    centerTitle: centerTitle,
    actions: [
      showSearchIcon
          ? IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search());
              },
              icon: const Icon(CupertinoIcons.search),
            )
          : const SizedBox()
    ],
    leading: withBackAction
        ? IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.black87,
            ))
        : null,
  );
}

const SizedBox sizedBox = SizedBox(height: 20);
