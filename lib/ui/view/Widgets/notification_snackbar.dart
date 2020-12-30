import 'package:attendance/constant/Constant.dart';
import 'package:flutter/material.dart';

class WidgetNotificationSnackbar {
  final Color color;
  final String message;

  WidgetNotificationSnackbar({this.color, this.message});

  render({BuildContext context, Color color, String message}) {
    // ignore: deprecated_member_use
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(15),
        duration: Duration(milliseconds: 1200),
        backgroundColor: color ?? greenColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        content: Text(message ?? ''),
      ),
    );
  }
}
