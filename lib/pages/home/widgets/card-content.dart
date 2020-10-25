import 'package:attendance/models/cards.dart';
import 'package:attendance/pages/home/widgets/card-detail-content.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CardContent extends StatefulWidget {
  final List<CameraDescription> cameras;
  final DataCards dataCards;
  final int length;

  CardContent(this.dataCards, this.length, this.cameras);

  @override
  _CardContentState createState() => _CardContentState();
}

class _CardContentState extends State<CardContent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        elevation: 5.5,
        margin: EdgeInsets.only(
          bottom: 25.0,
          left: 5.0,
          right: 5.0,
        ),
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: widget.dataCards.color, width: 15),
              ),
            ),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 100,
                  margin: EdgeInsets.only(
                    left: 15,
                    top: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  width: MediaQuery.of(context).size.width / 4.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(36.0)),
                  ),
                  child: Text(
                    widget.dataCards.classId,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.indigo[700],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 5,
                                  top: 10,
                                  bottom: 5,
                                ),
                                child: Text(
                                  "Punch In",
                                  style: TextStyle(
                                    color: Colors.indigo[800],
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 5,
                                  bottom: 10,
                                ),
                                child: Text(
                                  widget.dataCards.punchIn,
                                  style: TextStyle(
                                    color: Colors.indigo[800],
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          VerticalDivider(
                            thickness: 0.7,
                            color: Colors.indigo[900],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 5,
                                  top: 10,
                                  bottom: 5,
                                ),
                                child: Text(
                                  "Punch Out",
                                  style: TextStyle(
                                    color: Colors.indigo[800],
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 5,
                                  bottom: 10,
                                ),
                                child: Text(
                                  widget.dataCards.punchOut,
                                  style: TextStyle(
                                    color: Colors.indigo[800],
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10.0,
                      ),
                      child: Text(
                        widget.dataCards.subject,
                        style: TextStyle(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CardDetailContent(widget.cameras);
            },
          ),
        );
      },
    );
  }
}
