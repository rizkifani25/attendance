import 'package:attendance/constant/Constant.dart';
import 'package:attendance/models/models.dart';
import 'package:attendance/ui/view/Widgets/custom_dialog.dart';
import 'package:attendance/ui/view/Widgets/expandable_card/attend_info.dart';
import 'package:attendance/ui/view/Widgets/table_row_basic.dart';
import 'package:flutter/material.dart';

class StudentHistoryCard extends StatelessWidget {
  final RoomDetail roomDetail;
  final Time time;
  final Student student;

  StudentHistoryCard({this.roomDetail, this.time, this.student});

  final TextStyle textStyleTableHead = TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: primaryColor);
  final TextStyle textStyleTableCell = TextStyle(fontSize: 13);

  Enrolled _getStudentEnrolledDetail() {
    Enrolled enrolled;
    for (var i = 0; i < time.enrolled.length; i++) {
      if (time.enrolled[i].student.studentId == student.studentId) {
        enrolled = time.enrolled[i];
      }
    }
    return enrolled;
  }

  _handleTapMoreDetailPermission({BuildContext parentContext, Student student, Permission permission}) {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return CustomDialogBox(
          children: [
            SizedBox(height: 50),
            Center(child: Text('Permission')),
            Table(
              border: TableBorder.all(color: greyColor3, width: 1, style: BorderStyle.solid),
              children: [
                TableRowBasic().render(
                  tableHead: Text('Reason', style: textStyleTableHead),
                  tableCell: Text(permission.reason, style: textStyleTableCell),
                ),
                TableRowBasic().render(
                  tableHead: Text('Status', style: textStyleTableHead),
                  tableCell: Text(permission.statusPermission, style: textStyleTableCell),
                ),
              ],
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
    Enrolled enrolledStudent = _getStudentEnrolledDetail();

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
                children: [
                  TableRowBasic().render(
                    tableHead: Column(
                      children: [
                        Text(
                          enrolledStudent.student.studentId,
                          style: textStyleTableHead,
                        ),
                        Text(
                          enrolledStudent.student.studentName,
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
                              color: enrolledStudent.permission.reason == ''
                                  ? greyColor3
                                  : enrolledStudent.permission.statusPermission == 'Approved'
                                      ? greenColor
                                      : redColor,
                            ),
                            onTap: () => _handleTapMoreDetailPermission(parentContext: context, student: enrolledStudent.student, permission: enrolledStudent.permission),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(3),
                          child: GestureDetector(
                            child: Icon(
                              Icons.login_rounded,
                              size: 20,
                              color: enrolledStudent.attendStudent.distance > 0 && enrolledStudent.attendStudent.distance <= 5 ? greenColor : redColor,
                            ),
                            onTap: () => _handleTapMoreDetailAttend(parentContext: context, attendStudent: enrolledStudent.attendStudent),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(3),
                          child: GestureDetector(
                            child: Icon(
                              Icons.logout,
                              size: 20,
                              color: enrolledStudent.outStudent.distance == 0
                                  ? greyColor3
                                  : enrolledStudent.outStudent.distance > 0 && enrolledStudent.outStudent.distance <= 5
                                      ? greenColor
                                      : redColor,
                            ),
                            onTap: () => _handleTapMoreDetailOut(parentContext: context, outStudent: enrolledStudent.outStudent),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 5.5,
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
                tableHead: Text('Lecturer Name', style: textStyleTableHead),
                tableCell: Text(
                  time.lecturer.lecturerName,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              TableRowBasic().render(
                tableHead: Text('Lecturer Email', style: textStyleTableHead),
                tableCell: Text(
                  time.lecturer.lecturerEmail,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
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
