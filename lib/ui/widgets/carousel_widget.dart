import 'dart:convert';

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
