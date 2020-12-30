import 'package:attendance/constant/Constant.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class WidgetSlidingUpPanel extends StatefulWidget {
  final Widget panel;

  WidgetSlidingUpPanel({@required this.panel});

  @override
  _WidgetSlidingUpPanelState createState() => _WidgetSlidingUpPanelState();
}

class _WidgetSlidingUpPanelState extends State<WidgetSlidingUpPanel> {
  bool isDraggable = true;

  @override
  void initState() {
    super.initState();
    isDraggable = true;
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      isDraggable: isDraggable,
      defaultPanelState: PanelState.CLOSED,
      minHeight: MediaQuery.of(context).size.height * 0.5,
      maxHeight: MediaQuery.of(context).size.height * 0.85,
      margin: EdgeInsets.only(
        left: 1.5,
        right: 1.5,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(26.0),
        topRight: Radius.circular(26.0),
      ),
      body: Container(
        color: transparentColor,
      ),
      onPanelSlide: (double pos) {
        if (pos == 1.0) {
          setState(() {
            isDraggable = true;
          });
        }
      },
      panel: widget.panel,
    );
  }
}
