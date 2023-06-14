import 'package:flutter/material.dart';

import '../widgets/generic_app_bar.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(),
      body: const Text('More'),
    );
  }
}
