import 'package:flutter/material.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';

class AppOptions extends StatefulWidget {
  const AppOptions({super.key});

  @override
  State<AppOptions> createState() => _AppOptionsState();
}

class _AppOptionsState extends State<AppOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(context: context, title: 'App Options'),
    );
  }
}
