import 'package:attendance/models/cards.dart';
import 'package:attendance/models/pages.dart';
import 'package:attendance/pages/home/widgets/card-content.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePageContent extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomePageContent(this.cameras);

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
    dataCards.color = Colors.blue[700];
    dataCards.lecturer = "Sujono Jono";
    dataCards.subject = "Programming Concept";
    dataCards2.punchIn = "11:00";
    dataCards2.punchOut = "13:30";
    dataCards2.classId = "B404";
    dataCards2.color = Colors.blue[700];
    dataCards2.lecturer = "Mr. XYZ";
    dataCards2.subject = "Object Oriented Programming";
    dataCards3.punchIn = "14:00";
    dataCards3.punchOut = "16:30";
    dataCards3.classId = "B307";
    dataCards3.color = Colors.blue[700];
    dataCards3.lecturer = "Mr. XYZ";
    dataCards3.subject = "Server Side";
    dataCards4.punchIn = "17:00";
    dataCards4.punchOut = "19:30";
    dataCards4.classId = "B104";
    dataCards4.color = Colors.blue[700];
    dataCards4.lecturer = "Mr. XYZ";
    dataCards4.subject = "Client Side";
    dataCards5.punchIn = "17:00";
    dataCards5.punchOut = "19:30";
    dataCards5.classId = "B103";
    dataCards5.color = Colors.blue[700];
    dataCards5.lecturer = "Mr. XYZ";
    dataCards5.subject = "CGA";
    dataCards6.punchIn = "20:00";
    dataCards6.punchOut = "22:30";
    dataCards6.classId = "B301";
    dataCards6.color = Colors.blue[700];
    dataCards6.lecturer = "Mr. XYZ";
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
            margin: EdgeInsets.only(top: 25),
            child: Text(
              isPanelClosed ? "Welcome!!!" : "Today's Class",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.indigo[700],
                fontSize: 16.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          isPanelClosed ? _buildIsPanelClosedTrue(context) : _buildIsPanelClosedFalse(context),
        ],
      ),
    );
  }

  Widget _buildIsPanelClosedFalse(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: ListView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) {
          return CardContent(
              this.listDataCard[index], this.listDataCard.length, this.widget.cameras);
        },
        itemCount: listDataCard.length,
      ),
    );
  }

  Widget _buildIsPanelClosedTrue(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width / 1.5,
              margin: EdgeInsets.only(
                top: 60.0,
                left: 15.0,
                right: 5.0,
                bottom: 5.0,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[300],
                    width: 1.3,
                    style: BorderStyle.solid,
                  ),
                  bottom: BorderSide(
                    color: Colors.grey[300],
                    width: 1.3,
                    style: BorderStyle.solid,
                  ),
                  left: BorderSide(
                    color: Colors.grey[300],
                    width: 1.3,
                    style: BorderStyle.solid,
                  ),
                  right: BorderSide(
                    color: Colors.grey[300],
                    width: 1.3,
                    style: BorderStyle.solid,
                  ),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name\t: Muhammad Rizki Fani"),
                  Text("ID\t: 001201700038"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 50.0,
                left: 5.0,
                right: 15.0,
                bottom: 5.0,
              ),
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('https://via.placeholder.com/140x100'),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(
            top: 5.0,
            left: 5.0,
            right: 5.0,
          ),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage('https://via.placeholder.com/140x100'),
                ),
                title: Text(listDataCard[0].subject),
                subtitle: Text(
                  listDataCard[0].punchIn + " - " + listDataCard[0].punchOut,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 15.0),
                child: Text(
                  "Lecturer : " + listDataCard[0].lecturer,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Attend',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        color: Colors.green[700],
                      ),
                    ),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Dismiss',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        color: Colors.red[800],
                      ),
                    ),
                    onTap: () {
                      showAlertDialog(context);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // alert popup
  void showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Would you like to dismiss the " + listDataCard[0].subject + " class?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
