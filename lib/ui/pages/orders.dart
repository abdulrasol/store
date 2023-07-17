import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: genericAppBar(
          title: 'My Orders',
          withBackAction: true,
          centerTitle: true,
          showSearchIcon: false,
        ),
        body: Placeholder(
          color: Colors.cyanAccent,
        ));
  }
}
