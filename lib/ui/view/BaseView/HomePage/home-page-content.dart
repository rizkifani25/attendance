import 'package:attendance/ui/view/Widgets/sliding_up_panel.dart';
import 'package:flutter/material.dart';

class HomePageContent extends StatelessWidget {
  final List<Widget> children;
  HomePageContent({this.children});

  @override
  Widget build(BuildContext context) {
    return WidgetSlidingUpPanel(
      panel: SingleChildScrollView(
        child: Column(
          children: children ?? [],
        ),
      ),
    );
  }
}
