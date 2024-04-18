// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors, unused_import

class MyText extends StatelessWidget {
  MyText({key, required this.text, required this.textStyle});
  String text;
  TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
    );
  }
}
