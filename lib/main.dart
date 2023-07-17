import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:store/ui/pages/category.dart';
import 'package:store/ui/pages/main.dart';

void main() {
  runApp(app);
}

var app = GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.grey[50],
        elevation: 0,
        actionsIconTheme: const IconThemeData(
          color: Colors.black87,
        ),
      ),
    ),
    home: Main() // const CategoryPage(),
    // initialRoute: '/',
    );
