import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 14),
  filled: true,
  fillColor: Colors.white,
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: Colors.purple, width: 2)),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: Colors.grey, width: 2)),
);
