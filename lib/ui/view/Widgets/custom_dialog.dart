import 'dart:ui';
import 'package:attendance/constant/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatelessWidget {
  final List<Widget> children;

  CustomDialogBox({this.children});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          minHeight: 100,
          minWidth: 100,
          maxWidth: MediaQuery.of(context).size.width - 5,
          maxHeight: MediaQuery.of(context).size.height - 5,
        ),
        child: Stack(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                minHeight: 100,
                minWidth: 100,
                maxWidth: MediaQuery.of(context).size.width * 0.95,
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: Card(
                elevation: 5,
                margin: EdgeInsets.only(top: 30),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 25,
              right: 25,
              child: CircleAvatar(
                backgroundColor: secondaryColor,
                radius: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  child: Image.asset('assets/icon/calendar.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
