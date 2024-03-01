// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String textContent;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;

  const CustomText({
    required this.textContent,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textContent,
      style: TextStyle(
        color: textColor,
        fontFamily: 'Ubuntu',
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}

