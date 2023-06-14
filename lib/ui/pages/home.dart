import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:store/ui/widgets/carousel_widget.dart';
import 'package:store/ui/widgets/catrgories_wrap.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';
import 'package:store/ui/widgets/home_sector.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var itemList = [
    {'name': 'Title of Item', 'price': 12, 'image': 'url'},
    {'name': 'Title of Item', 'price': 12, 'image': 'url'},
    {'name': 'Title of Item', 'price': 12, 'image': 'url'},
    {'name': 'Title of Item', 'price': 12, 'image': 'url'},
  ];

  var carItems = [
    carouselWidget(
      banner: 'assets/imgs/banner1.jpg',
      headline: 'Title of ads',
      bodytext: 'describe for what you want',
    ),
    carouselWidget(
      headline: 'Title of ads',
      bodytext: 'describe for what you want',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(title: 'AppStore'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CarouselSlider(
                items: carItems,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 4,
                  autoPlay: true,
                ),
              ),
              homeSection([], title: 'New Arival'),
              homeSection([], title: 'Discounts'),
              homeSection([], title: 'Featured'),
              categoriesWrap()
            ],
          ),
        ),
      ),
    );
  }
}
