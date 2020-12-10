import 'package:attendance/constant/Constant.dart';
import 'package:flutter/material.dart';

class WidgetFont extends StatelessWidget {
  final Color color;
  final double fontSize;
  final String text;
  final FontWeight weight;

  WidgetFont({this.color, this.fontSize, @required this.text, this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? greyColor3,
        fontSize: fontSize ?? 20,
        fontWeight: weight ?? FontWeight.normal,
      ),
    );
  }
}
