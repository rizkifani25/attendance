import 'package:attendance/constant/Constant.dart';
import 'package:flutter/material.dart';

class LoginAs extends StatelessWidget {
  final String text;
  final Function onTap;

  LoginAs({@required this.text, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Text(
          text,
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: blueColor,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
