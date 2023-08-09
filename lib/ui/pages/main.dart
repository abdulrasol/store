import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:store/ui/pages/cart.dart';
import 'package:store/ui/pages/categories.dart';
import 'package:store/ui/pages/home.dart';
import 'package:store/ui/pages/more.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  var _boNaBaIndex = 0;
  var pages = [
    const Home(),
    const Categories(),
    const Cart(),
    More(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_boNaBaIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _boNaBaIndex,
        onTap: (i) => setState(() {
          _boNaBaIndex = i;
        }),
        items: [
          SalomonBottomBarItem(
              icon: const Icon(CupertinoIcons.home),
              title: const Text('Home'),
              unselectedColor: Colors.black54,
              selectedColor: Colors.black87),
          SalomonBottomBarItem(
              icon: const Icon(Icons.category),
              title: const Text('Categories'),
              unselectedColor: Colors.black54,
              selectedColor: Colors.black87),
          SalomonBottomBarItem(
            icon: const Icon(CupertinoIcons.cart),
            title: const Text('Cart'),
            unselectedColor: Colors.black54,
            selectedColor: Colors.black87,
          ),
          SalomonBottomBarItem(
              icon: const Icon(CupertinoIcons.settings),
              title: const Text('More'),
              unselectedColor: Colors.black54,
              selectedColor: Colors.black87),
        ],
      ),
    );
  }
}
