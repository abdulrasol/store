import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:store/database/fetech/general.dart';
import 'package:store/database/models/slider_model.dart';
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
              FutureBuilder<QuerySnapshot>(
                future: getSliders(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<SildeModel> slides = snapshot.data!.docs.map((slide) {
                      return SildeModel.fromMap(
                          slide.data() as Map<String, dynamic>);
                    }).toList();
                    return CarouselSlider(
                      items:
                          slides.map((slide) => carouselWidget(slide)).toList(),
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height / 4,
                        autoPlay: true,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
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
