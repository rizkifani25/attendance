import 'package:attendance/constant/Constant.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class WidgetSlidingUpPanel {
  SlidingUpPanel slidingUpPanel({BuildContext context, Widget Function(ScrollController) panel}) {
    return SlidingUpPanel(
      isDraggable: true,
      defaultPanelState: PanelState.CLOSED,
      minHeight: MediaQuery.of(context).size.height / 2.2,
      maxHeight: MediaQuery.of(context).size.height / 1.17,
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
      panelBuilder: panel,
    );
  }
}
