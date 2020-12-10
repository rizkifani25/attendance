import 'package:attendance/constant/Constant.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';

class WidgetBadge extends StatelessWidget {
  final String value;
  WidgetBadge({@required this.value});

  @override
  Widget build(BuildContext context) {
    return Badge(
      animationDuration: Duration(milliseconds: 300),
      animationType: BadgeAnimationType.scale,
      shape: BadgeShape.square,
      badgeColor: primaryColor,
      borderRadius: BorderRadius.circular(8),
      badgeContent: Text(
        value ?? '',
        style: TextStyle(color: secondaryColor),
      ),
    );
  }
}
