import 'package:attendance/constant/Constant.dart';
import 'package:attendance/models/room_detail_response.dart';
import 'package:attendance/models/time.dart';
import 'package:attendance/ui/view/HomeView/widgets/card-detail-content.dart';
import 'package:camera/camera.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class CardContent extends StatefulWidget {
  final List<CameraDescription> cameras;
  final RoomDetailResponse roomDetailResponse;
  final String studentId;

  CardContent({this.roomDetailResponse, this.cameras, this.studentId});

  @override
  _CardContentState createState() => _CardContentState();
}

class _CardContentState extends State<CardContent> {
  RoomDetailResponse _roomDetailResponse;
  String _studentId;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _studentId = widget.studentId;
    _roomDetailResponse = widget.roomDetailResponse;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Time> _filteredTime = [];

    for (var i = 0;
        i < _roomDetailResponse.listTime.time1.enrolled.length;
        i++) {
      if (_roomDetailResponse.listTime.time1.enrolled[i].studentId ==
          _studentId) {
        _filteredTime.add(_roomDetailResponse.listTime.time1);
      }
    }
    for (var i = 0;
        i < _roomDetailResponse.listTime.time2.enrolled.length;
        i++) {
      if (_roomDetailResponse.listTime.time2.enrolled[i].studentId ==
          _studentId) {
        _filteredTime.add(_roomDetailResponse.listTime.time2);
      }
    }
    for (var i = 0;
        i < _roomDetailResponse.listTime.time3.enrolled.length;
        i++) {
      if (_roomDetailResponse.listTime.time3.enrolled[i].studentId ==
          _studentId) {
        _filteredTime.add(_roomDetailResponse.listTime.time3);
      }
    }
    for (var i = 0;
        i < _roomDetailResponse.listTime.time4.enrolled.length;
        i++) {
      if (_roomDetailResponse.listTime.time4.enrolled[i].studentId ==
          _studentId) {
        _filteredTime.add(_roomDetailResponse.listTime.time4);
      }
    }

    print(_filteredTime.length);

    return Container(
      width: MediaQuery.of(context).size.width,
      child: ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            elevation: 5,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      // tapBodyToCollapse: true,
                    ),
                    header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        _roomDetailResponse.roomName,
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ),
                    collapsed: Text(
                      'You have ' +
                          _filteredTime.length.toString() +
                          (_filteredTime.length > 1 ? ' classes' : ' class'),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _filteredTime.map(
                        (e) {
                          return InkWell(
                            child: Card(
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(e.time),
                                      Text(e.lecturer),
                                      Text(e.subject),
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
                        },
                      ).toList(),
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// return InkWell(
//       child: Card(
//         color: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(24.0),
//         ),
//         elevation: 5.5,
//         margin: EdgeInsets.only(
//           bottom: 25.0,
//           left: 5.0,
//           right: 5.0,
//         ),
//         child: ClipPath(
//           clipper: ShapeBorderClipper(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(24.0),
//             ),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border(
//                 top: BorderSide(color: widget.dataCards.color, width: 15),
//               ),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//                   height: 100,
//                   margin: EdgeInsets.only(
//                     left: 15,
//                     top: 10,
//                     right: 10,
//                     bottom: 10,
//                   ),
//                   width: MediaQuery.of(context).size.width / 4.0,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.all(Radius.circular(36.0)),
//                   ),
//                   child: Text(
//                     widget.dataCards.classId,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.indigo[700],
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     IntrinsicHeight(
//                       child: Row(
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 10,
//                                   right: 5,
//                                   top: 10,
//                                   bottom: 5,
//                                 ),
//                                 child: Text(
//                                   "Punch In",
//                                   style: TextStyle(
//                                     color: Colors.indigo[800],
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 10,
//                                   right: 5,
//                                   bottom: 10,
//                                 ),
//                                 child: Text(
//                                   widget.dataCards.punchIn,
//                                   style: TextStyle(
//                                     color: Colors.indigo[800],
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           VerticalDivider(
//                             thickness: 0.7,
//                             color: Colors.indigo[900],
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 10,
//                                   right: 5,
//                                   top: 10,
//                                   bottom: 5,
//                                 ),
//                                 child: Text(
//                                   "Punch Out",
//                                   style: TextStyle(
//                                     color: Colors.indigo[800],
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 10,
//                                   right: 5,
//                                   bottom: 10,
//                                 ),
//                                 child: Text(
//                                   widget.dataCards.punchOut,
//                                   style: TextStyle(
//                                     color: Colors.indigo[800],
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(
//                         top: 10.0,
//                       ),
//                       child: Text(
//                         widget.dataCards.subject,
//                         style: TextStyle(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) {
//               return CardDetailContent(widget.cameras);
//             },
//           ),
//         );
//       },
//     );
//   }
