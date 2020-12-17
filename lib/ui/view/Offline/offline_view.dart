import 'package:attendance/ui/view/Widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

class OfflineView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomDialogBox(
      children: [
        SizedBox(height: 50),
        Center(
          child: Text('Ups.. No Internet Connection'),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}
