import 'package:flutter/material.dart';

Card carouselWidget(
    {String banner = 'assets/imgs/banner2.png',
    String headline = '',
    String bodytext = ''}) {
  return Card(
    shape: Border.all(),
    shadowColor: Colors.black12,
    elevation: 0.1,
    margin: const EdgeInsets.all(2.0),
    child: Stack(
      fit: StackFit.expand,
      //alignment: AlignmentDirectional.bottomStart,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Image.asset(
            banner,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 25,
          left: 10,
          child: Text(
            headline,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Text(
            bodytext,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    ),
  );
}
