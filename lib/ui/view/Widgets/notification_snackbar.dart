import 'package:attendance/constant/Constant.dart';
import 'package:flutter/material.dart';

class WidgetNotificationSnackbar {
  final Color color;
  final String message;

  WidgetNotificationSnackbar({this.color, this.message});

  render({BuildContext context, Color color, String message}) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 750),
        backgroundColor: color ?? greenColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
        content: Text(message ?? ''),
      ),
    );
  }
}
