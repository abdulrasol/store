import 'package:flutter/material.dart';
import 'package:store/ui/widgets/catrgories_wrap.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';
import 'package:store/ui/widgets/page_title.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: genericAppBar(context: context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              pageTitle('Categories'),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: categoriesWrap(withTitle: false),
              )
            ],
          ),
        ));
  }
}
