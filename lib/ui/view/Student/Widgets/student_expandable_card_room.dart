import 'package:attendance/models/models.dart';
import 'package:attendance/ui/view/Student/Widgets/student_card_detail_class.dart';
import 'package:camera/camera.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetStudentExpandableCardRoom extends StatelessWidget {
  final List<CameraDescription> cameras;
  final RoomDetailResponse roomDetail;
  final Student student;

  WidgetStudentExpandableCardRoom({this.cameras, this.roomDetail, this.student});

  @override
  Widget build(BuildContext context) {
    final List<Time> listTime = [];

    Time time1 = roomDetail.listTime.time1;
    Time time2 = roomDetail.listTime.time2;
    Time time3 = roomDetail.listTime.time3;
    Time time4 = roomDetail.listTime.time4;

    for (var i = 0; i < time1.enrolled.length; i++) {
      if (time1.enrolled[i].student.studentId == student.studentId) {
        listTime.add(roomDetail.listTime.time1);
      }
    }

    for (var i = 0; i < time2.enrolled.length; i++) {
      if (time2.enrolled[i].student.studentId == student.studentId) {
        listTime.add(roomDetail.listTime.time2);
      }
    }

    for (var i = 0; i < time3.enrolled.length; i++) {
      if (time3.enrolled[i].student.studentId == student.studentId) {
        listTime.add(roomDetail.listTime.time3);
      }
    }

    for (var i = 0; i < time4.enrolled.length; i++) {
      if (time4.enrolled[i].student.studentId == student.studentId) {
        listTime.add(roomDetail.listTime.time4);
      }
    }

    return ExpandableNotifier(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: false,
                  ),
                  header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      roomDetail.roomId,
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
                  collapsed: Text(
                    'You have ' + listTime.length.toString() + (listTime.length > 1 ? ' classes' : ' class'),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: listTime.map((e) {
                      return WidgetStudentCardDetailClass(cameras: cameras, roomDetail: roomDetail, time: e, student: student);
                    }).toList(),
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
    );
  }
}
