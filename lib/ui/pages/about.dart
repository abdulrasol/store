import 'package:flutter/material.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(context: context, title: 'About'),
    );
  }
}
