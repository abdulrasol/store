import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:store/database/services/controller.dart';
import 'package:store/ui/widgets/carousel_widget.dart';
import 'package:store/ui/widgets/catrgories_wrap.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';
import '../widgets/home_secter_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(
        title: 'AppStore',
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() {
                if (controller.sliders.isNotEmpty) {
                  return CarouselSlider(
                    items: controller.sliders
                        .map((slide) => carouselWidget(slide))
                        .toList(),
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height / 4,
                      autoPlay: true,
                    ),
                  );
                } else {
                  return CarouselSlider(
                    items: [carouselWidgetShimmer(), carouselWidgetShimmer()],
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height / 4,
                      autoPlay: true,
                    ),
                  );
                }
              }),
              homeSectionList([], title: 'New Arival'),
              homeSectionList([], title: 'Discounts'),
              homeSectionList([], title: 'Featured'),
              categoriesWrap()
            ],
          ),
        ),
      ),
    );
  }
}
