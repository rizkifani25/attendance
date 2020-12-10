import 'package:attendance/ui/view/Widgets/panel.dart';
import 'package:attendance/ui/view/Widgets/sliding_up_panel.dart';
import 'package:flutter/material.dart';

class ClassPageContent extends StatelessWidget {
  final List<Widget> children;
  ClassPageContent({this.children});

  @override
  Widget build(BuildContext context) {
    return WidgetSlidingUpPanel().slidingUpPanel(
      context: context,
      panel: (scrollController) => WidgetPanel().panel(
        context: context,
        scrollController: scrollController,
        children: children ?? [],
      ),
    );
  }
}
