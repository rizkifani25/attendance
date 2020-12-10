import 'package:attendance/constant/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetLogOutButton extends StatelessWidget {
  final Function handleSignOutButton;

  WidgetLogOutButton({@required this.handleSignOutButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 20),
      child: RaisedButton(
        color: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Text(
          'Log Out',
          style: TextStyle(color: secondaryColor),
        ),
        onPressed: handleSignOutButton,
      ),
    );
  }
}
