import 'package:attendance/constant/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 3,
      color: greyColor3,
      indent: MediaQuery.of(context).size.width / 2 - 15,
      endIndent: MediaQuery.of(context).size.width / 2 - 15,
    );
  }
}
