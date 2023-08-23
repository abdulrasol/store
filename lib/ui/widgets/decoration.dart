import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var inputDecoration = InputDecoration(
  prefixIcon: const Icon(
    CupertinoIcons.at,
    color: Colors.black87,
  ),
  label: const Text(
    'Email',
    style: TextStyle(color: Colors.black87),
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
    ),
    borderRadius: BorderRadius.all(Radius.circular(7.0)),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      width: 2,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red.shade300,
      width: 1,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red.shade300,
      width: 2,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(7.0),
    ),
  ),
);
