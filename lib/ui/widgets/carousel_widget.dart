import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:store/database/models/slider_model.dart';

Card carouselWidget(SildeModel slide) {
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
          child: Image.memory(
            base64Decode(slide.image),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 25,
          left: 10,
          child: Text(
            slide.title,
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
            slide.text,
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

Card carouselWidgetShimmer() {
  return Card(
    shape: Border.all(),
    shadowColor: Colors.black12,
    elevation: 0.1,
    margin: const EdgeInsets.all(2.0),
    child: Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.white,
              child: Container(
                color: Colors.grey[200],
              ),
            )),
        Positioned(
          bottom: 30,
          left: 10,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.white,
            child: Container(
              color: Color.fromARGB(255, 155, 154, 154),
              width: 200,
              height: 16,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.white,
            child: Container(
              color: Colors.grey[100],
              width: 300,
              height: 16,
            ),
          ),
        ),
      ],
    ),
  );
}
/*
SizedBox(
  width: 200.0,
  height: 100.0,
  child: Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
    child: Text(
      'Shimmer',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 40.0,
        fontWeight:
        FontWeight.bold,
      ),
    ),
  ),
);
*/