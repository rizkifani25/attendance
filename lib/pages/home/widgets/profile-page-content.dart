import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProfilePageContent extends StatefulWidget {
  @override
  _ProfilePageContentState createState() => _ProfilePageContentState();
}

class _ProfilePageContentState extends State<ProfilePageContent> {
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
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
        color: Colors.transparent,
      ),
      panel: Stack(
        alignment: Alignment.topCenter,
        children: [
          Divider(
            thickness: 4.5,
            color: Colors.grey[400],
            indent: MediaQuery.of(context).size.width / 2 - 16.5,
            endIndent: MediaQuery.of(context).size.width / 2 - 16.5,
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Profile",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.indigo[700],
                fontSize: 16.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
