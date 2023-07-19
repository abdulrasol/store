import 'package:flutter/material.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';

class Prfile extends StatelessWidget {
  const Prfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: genericAppBar(
          title: 'My Profile',
          withBackAction: true,
          centerTitle: true,
          showSearchIcon: false,
        ),
        body: const Placeholder(
          color: Colors.cyanAccent,
        ));
  }
}
