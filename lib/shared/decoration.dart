import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  hintText: 'Email',
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromARGB(255, 30, 111, 233), width: 2.0)));
