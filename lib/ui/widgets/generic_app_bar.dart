import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar genericAppBar({String title = '', bool withBackAction = false}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(color: Colors.black87),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(CupertinoIcons.search),
      )
    ],
    leading: withBackAction
        ? IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.black87,
            ))
        : null,
  );
}
