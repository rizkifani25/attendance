import 'package:attendance/constant/Constant.dart';
import 'package:attendance/models/enrolled_student.dart';
import 'package:attendance/models/room_detail_response.dart';
import 'package:attendance/models/time.dart';
import 'package:attendance/ui/view/HomeView/widgets/card-detail-content.dart';
import 'package:badges/badges.dart';
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
    List<Enrolled> _enrolledStudent = [];

    for (var i = 0; i < _roomDetailResponse.listTime.time1.enrolled.length; i++) {
      if (_roomDetailResponse.listTime.time1.enrolled[i].studentId == _studentId) {
        _filteredTime.add(_roomDetailResponse.listTime.time1);
        _enrolledStudent.add(_roomDetailResponse.listTime.time1.enrolled[i]);
      }
    }
    for (var i = 0; i < _roomDetailResponse.listTime.time2.enrolled.length; i++) {
      if (_roomDetailResponse.listTime.time2.enrolled[i].studentId == _studentId) {
        _filteredTime.add(_roomDetailResponse.listTime.time2);
        _enrolledStudent.add(_roomDetailResponse.listTime.time2.enrolled[i]);
      }
    }
    for (var i = 0; i < _roomDetailResponse.listTime.time3.enrolled.length; i++) {
      if (_roomDetailResponse.listTime.time3.enrolled[i].studentId == _studentId) {
        _filteredTime.add(_roomDetailResponse.listTime.time3);
        _enrolledStudent.add(_roomDetailResponse.listTime.time3.enrolled[i]);
      }
    }
    for (var i = 0; i < _roomDetailResponse.listTime.time4.enrolled.length; i++) {
      if (_roomDetailResponse.listTime.time4.enrolled[i].studentId == _studentId) {
        _filteredTime.add(_roomDetailResponse.listTime.time4);
        _enrolledStudent.add(_roomDetailResponse.listTime.time4.enrolled[i]);
      }
    }

    final List fixedList = Iterable<int>.generate(_filteredTime.length).toList();

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
                      children: fixedList.map(
                        (e) {
                          return InkWell(
                            child: Card(
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(_filteredTime[e].time),
                                          Text(_filteredTime[e].lecturer),
                                          Text(_filteredTime[e].subject),
                                        ],
                                      ),
                                      _statusAttendance(_enrolledStudent[e].status),
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
                                    return CardDetailContent(
                                      widget.cameras,
                                      studentId: _studentId,
                                      roomId: _roomDetailResponse.roomId,
                                      time: _filteredTime[e].time,
                                    );
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
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
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

  Widget _statusAttendance(int status) {
    return Badge(
      animationDuration: Duration(milliseconds: 300),
      animationType: BadgeAnimationType.scale,
      shape: BadgeShape.square,
      badgeColor: status == 0
          ? greenColor
          : status == 1
              ? blueColor
              : redColor,
      borderRadius: BorderRadius.circular(8),
      badgeContent: Text(
        status == 0
            ? 'valid'
            : status == 1
                ? 'not validated'
                : 'not valid',
        style: TextStyle(color: secondaryColor),
      ),
    );
  }
}
