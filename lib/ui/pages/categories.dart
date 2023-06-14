import 'package:flutter/material.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(),
      body: const Text('Categories'),
    );
  }
}
