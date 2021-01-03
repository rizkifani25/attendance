import 'package:attendance/constant/Constant.dart';
import 'package:attendance/models/models.dart';
import 'package:attendance/ui/view/Widgets/custom_dialog.dart';
import 'package:attendance/ui/view/Widgets/expandable_card/attend_info.dart';
import 'package:attendance/ui/view/Widgets/expandable_card/permission_info.dart';
import 'package:attendance/ui/view/Widgets/table_row_basic.dart';
import 'package:flutter/material.dart';

class LecturerHistoryCard extends StatelessWidget {
  final RoomDetail roomDetail;
  final Time time;

  LecturerHistoryCard({this.roomDetail, this.time});

  _handleTapMoreDetailPermission({BuildContext parentContext, Student student, Permission permission}) {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return CustomDialogBox(
          children: [
            SizedBox(height: 50),
            Center(child: Text('Permission')),
            PermissionInfo(
              permission: permission,
              roomId: roomDetail.roomId,
              time: time.time,
              studentId: student.studentId,
            ),
          ],
        );
      },
    );
  }

  _handleTapMoreDetailAttend({BuildContext parentContext, AttendStudent attendStudent}) {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return CustomDialogBox(
          children: [
            SizedBox(height: 50),
            Center(child: Text('Detail Attend')),
            AttendOutInfo(attendStudent: attendStudent),
          ],
        );
      },
    );
  }

  _handleTapMoreDetailOut({BuildContext parentContext, OutStudent outStudent}) {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return CustomDialogBox(
          children: [
            SizedBox(height: 50),
            Center(child: Text('Detail Out')),
            AttendOutInfo(outStudent: outStudent),
          ],
        );
      },
    );
  }

  _handleTapDetail({BuildContext parentContext}) {
    TextStyle textStyleTableHead = TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: primaryColor);
    TextStyle textStyleTableCell = TextStyle(fontSize: 13);

    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return CustomDialogBox(
          children: [
            SizedBox(height: 50),
            Center(child: Text('Enrolled')),
            Padding(
              padding: EdgeInsets.all(3),
              child: Table(
                border: TableBorder.all(color: greyColor3, width: 1, style: BorderStyle.solid),
                children: time.enrolled.map((e) {
                  return TableRowBasic().render(
                    tableHead: Column(
                      children: [
                        Text(
                          e.student.studentId,
                          style: textStyleTableHead,
                        ),
                        Text(
                          e.student.studentName,
                          textAlign: TextAlign.center,
                          style: textStyleTableCell,
                        ),
                      ],
                    ),
                    tableCell: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.all(3),
                          child: GestureDetector(
                            child: Icon(
                              Icons.info_rounded,
                              size: 20,
                              color: e.permission.reason == ''
                                  ? greyColor3
                                  : e.permission.statusPermission == 'Approved'
                                      ? greenColor
                                      : redColor,
                            ),
                            onTap: () => _handleTapMoreDetailPermission(parentContext: context, student: e.student, permission: e.permission),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(3),
                          child: GestureDetector(
                            child: Icon(
                              Icons.login_rounded,
                              size: 20,
                              color: e.attendStudent.distance > 0 && e.attendStudent.distance <= 5 ? greenColor : redColor,
                            ),
                            onTap: () => _handleTapMoreDetailAttend(parentContext: context, attendStudent: e.attendStudent),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(3),
                          child: GestureDetector(
                            child: Icon(
                              Icons.logout,
                              size: 20,
                              color: e.outStudent.distance == 0
                                  ? greyColor3
                                  : e.outStudent.distance > 0 && e.outStudent.distance <= 5
                                      ? greenColor
                                      : redColor,
                            ),
                            onTap: () => _handleTapMoreDetailOut(parentContext: context, outStudent: e.outStudent),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleTableHead = TextStyle(fontSize: 13, fontWeight: FontWeight.bold);
    TextStyle textStyleTableCell = TextStyle(fontSize: 13);
    TextStyle textStyleTableCellChild = TextStyle(fontSize: 13);

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Table(
            border: TableBorder.all(color: greyColor3, width: 1, style: BorderStyle.solid),
            children: [
              TableRowBasic().render(
                tableHead: Text('Date', style: textStyleTableHead),
                tableCell: Text(
                  roomDetail.date,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              TableRowBasic().render(
                tableHead: Text('Time', style: textStyleTableHead),
                tableCell: Text(
                  time.time,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              TableRowBasic().render(
                tableHead: Text('Room Status', style: textStyleTableHead),
                tableCell: Text(
                  time.status.statusMessage,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              TableRowBasic().render(
                tableHead: Text('Subject', style: textStyleTableHead),
                tableCell: Text(
                  time.subject,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              TableRowBasic().render(
                tableHead: Text('Enrolled', style: textStyleTableHead),
                tableCell: Text(
                  time.enrolled.length.toString(),
                  textAlign: TextAlign.end,
                  style: textStyleTableCellChild,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () => _handleTapDetail(parentContext: context),
    );
  }
}
