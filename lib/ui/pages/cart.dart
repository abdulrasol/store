import 'package:flutter/material.dart';

import '../widgets/generic_app_bar.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(withBackAction: true),
      body: const Text('Cart'),
    );
  }
}
