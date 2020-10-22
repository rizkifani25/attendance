import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ClassPageContent extends StatefulWidget {
  @override
  _ClassPageContentState createState() => _ClassPageContentState();
}

class _ClassPageContentState extends State<ClassPageContent> {
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      defaultPanelState: PanelState.OPEN,
      minHeight: MediaQuery.of(context).size.height / 3.5,
      margin: EdgeInsets.only(
        left: 1.5,
        right: 1.5,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(26.0),
        topRight: Radius.circular(26.0),
      ),
      body: Container(
        color: Colors.transparent,
      ),
      panel: Container(
        margin: EdgeInsets.only(top: 15),
        child: Text(
          "Class",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
