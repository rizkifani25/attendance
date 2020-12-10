import 'package:attendance/models/models.dart';
import 'package:attendance/ui/view/Lecturer/Widgets/card_detail_class.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetLecturerExpandableCardRoom extends StatelessWidget {
  final RoomDetailResponse roomDetail;
  final Lecturer lecturer;

  WidgetLecturerExpandableCardRoom({this.roomDetail, this.lecturer});

  @override
  Widget build(BuildContext context) {
    final List<Time> listTime = [];

    if (roomDetail.listTime.time1.lecturer.lecturerEmail == lecturer.lecturerEmail) {
      listTime.add(roomDetail.listTime.time1);
    }
    if (roomDetail.listTime.time2.lecturer.lecturerEmail == lecturer.lecturerEmail) {
      listTime.add(roomDetail.listTime.time2);
    }
    if (roomDetail.listTime.time3.lecturer.lecturerEmail == lecturer.lecturerEmail) {
      listTime.add(roomDetail.listTime.time3);
    }
    if (roomDetail.listTime.time4.lecturer.lecturerEmail == lecturer.lecturerEmail) {
      listTime.add(roomDetail.listTime.time4);
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
                      return WidgetLecturerCardDetailClass(roomDetail: roomDetail, time: e);
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
