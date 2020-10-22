import 'package:attendance/models/cards.dart';
import 'package:attendance/models/pages.dart';
import 'package:attendance/pages/home/widgets/card-content.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  DataPages dataPages;
  List<DataCards> listDataCard = [];
  bool isPanelClosed = true;

  @override
  void initState() {
    DataCards dataCards = new DataCards();
    DataCards dataCards2 = new DataCards();
    DataCards dataCards3 = new DataCards();
    DataCards dataCards4 = new DataCards();
    DataCards dataCards5 = new DataCards();
    DataCards dataCards6 = new DataCards();

    dataCards.punchIn = "07:30";
    dataCards.punchOut = "10:00";
    dataCards.classId = "B101";
    dataCards.color = Colors.lime[400];
    dataCards.subject = "Programming Concept";
    dataCards2.punchIn = "11:00";
    dataCards2.punchOut = "13:30";
    dataCards2.classId = "B404";
    dataCards2.color = Colors.green[900];
    dataCards2.subject = "Object Oriented Programming";
    dataCards3.punchIn = "14:00";
    dataCards3.punchOut = "16:30";
    dataCards3.classId = "B307";
    dataCards3.color = Colors.pink;
    dataCards3.subject = "Server Side";
    dataCards4.punchIn = "17:00";
    dataCards4.punchOut = "19:30";
    dataCards4.classId = "B104";
    dataCards4.color = Colors.cyan;
    dataCards4.subject = "Client Side";
    dataCards5.punchIn = "17:00";
    dataCards5.punchOut = "19:30";
    dataCards5.classId = "B103";
    dataCards5.color = Colors.red;
    dataCards5.subject = "CGA";
    dataCards6.punchIn = "20:00";
    dataCards6.punchOut = "22:30";
    dataCards6.classId = "B301";
    dataCards6.color = Colors.yellow;
    dataCards6.subject = "3D CGA";

    listDataCard.add(dataCards);
    listDataCard.add(dataCards2);
    listDataCard.add(dataCards3);
    listDataCard.add(dataCards4);
    listDataCard.add(dataCards5);
    listDataCard.add(dataCards6);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      defaultPanelState: PanelState.CLOSED,
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
      onPanelClosed: () {
        setState(() {
          isPanelClosed = true;
        });
      },
      onPanelOpened: () {
        setState(() {
          isPanelClosed = false;
        });
      },
      panel: isPanelClosed ? _buildIsPanelClosedTrue(context) : _buildIsPanelClosedFalse(context),
    );
  }

  Widget _buildIsPanelClosedFalse(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: ListView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) {
          return CardContent(this.listDataCard[index], this.listDataCard.length);
        },
        itemCount: listDataCard.length,
      ),
    );
  }

  Widget _buildIsPanelClosedTrue(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: ListView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) {
          return CardContent(this.listDataCard[0], 1);
        },
        itemCount: 1,
      ),
    );
  }
}
