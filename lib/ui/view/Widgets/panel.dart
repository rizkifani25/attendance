import 'package:flutter/cupertino.dart';

class WidgetPanel {
  Widget panel({BuildContext context, ScrollController scrollController, List<Widget> children}) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        scrollDirection: Axis.vertical,
        controller: scrollController,
        children: children,
      ),
    );
  }
}
