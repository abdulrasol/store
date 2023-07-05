import 'package:flutter/material.dart';

SizedBox pageTitle(String title) {
  return SizedBox(
    width: double.infinity,
    //height: 50,
    child: Center(
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.black54,
        ),
      ),
    ),
  );
}
