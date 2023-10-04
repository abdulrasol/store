import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:store/ui/pages/cart.dart';
import 'package:store/ui/pages/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:store/ui/pages/options.dart';
import 'package:store/ui/pages/order1.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
  routes: {
    //'main': (contect) => const Main(),
    'cart': (contect) => const Cart(),
    'options': (contect) => Options(),
  },
  initialRoute: 'main',
  home: const Main(),
);
