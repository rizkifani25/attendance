import 'package:attendance/ui/view/Widgets/panel.dart';
import 'package:attendance/ui/view/Widgets/sliding_up_panel.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class HomePageContent extends StatelessWidget {
  final List<CameraDescription> cameras;
  final List<Widget> children;
  HomePageContent({this.cameras, this.children});

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
