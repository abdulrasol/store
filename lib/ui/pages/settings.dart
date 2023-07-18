import 'package:flutter/material.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: genericAppBar(
          title: 'Settings',
          withBackAction: true,
          centerTitle: true,
          showSearchIcon: false,
        ),
        body: const Placeholder(
          color: Colors.cyanAccent,
        ));
  }
}
