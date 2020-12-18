import 'package:attendance/constant/Constant.dart';
import 'package:attendance/models/models.dart';
import 'package:flutter/material.dart';

class StudentHistoryCard extends StatelessWidget {
  final RoomDetail roomDetail;
  final Time time;
  final Student student;

  StudentHistoryCard({this.roomDetail, this.time, this.student});

  Enrolled _getStudentEnrolledDetail() {
    Enrolled enrolled;
    for (var i = 0; i < time.enrolled.length; i++) {
      if (time.enrolled[i].student.studentId == student.studentId) {
        enrolled = time.enrolled[i];
      }
    }
    return enrolled;
  }

  @override
  Widget build(BuildContext context) {
    final Enrolled enrolledStudent = _getStudentEnrolledDetail();

    TextStyle textStyleTableHead = TextStyle(fontSize: 13, fontWeight: FontWeight.bold);
    TextStyle textStyleTableCell = TextStyle(fontSize: 13);
    TextStyle textStyleTableCellChild = TextStyle(fontSize: 13);

    return InkWell(
      child: Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 5.5,
          child: Table(
            border: TableBorder.all(color: greyColor3, width: 1, style: BorderStyle.solid),
            children: [
              _tableRowBasic(
                tableHead: Text('Room ID', style: textStyleTableHead),
                tableCell: Text(
                  roomDetail.roomId,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Room Name', style: textStyleTableHead),
                tableCell: Text(
                  roomDetail.roomName,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Date', style: textStyleTableHead),
                tableCell: Text(
                  roomDetail.date,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Time', style: textStyleTableHead),
                tableCell: Text(
                  time.time,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Room Status', style: textStyleTableHead),
                tableCell: Text(
                  time.status.statusMessage,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Subject', style: textStyleTableHead),
                tableCell: Text(
                  time.subject,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Lecturer Name', style: textStyleTableHead),
                tableCell: Text(
                  time.lecturer.lecturerName,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Lecturer Email', style: textStyleTableHead),
                tableCell: Text(
                  time.lecturer.lecturerEmail,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Attend', style: textStyleTableHead),
                tableCell: Table(
                  border: TableBorder.all(color: greyColor3, width: 1, style: BorderStyle.solid),
                  children: [
                    _tableRowBasic(
                      tableHead: Text(
                        'Status (photo)',
                        style: textStyleTableCellChild,
                      ),
                      tableCell: Text(
                        enrolledStudent.statusAttendance.byPhoto,
                        textAlign: TextAlign.end,
                        style: textStyleTableCellChild,
                      ),
                    ),
                    _tableRowBasic(
                      tableHead: Text(
                        'Status (distance)',
                        style: textStyleTableCellChild,
                      ),
                      tableCell: Text(
                        enrolledStudent.statusAttendance.byDistance + '(' + enrolledStudent.attendStudent.distance.toStringAsFixed(2) + ')',
                        textAlign: TextAlign.end,
                        style: textStyleTableCellChild,
                      ),
                    ),
                    _tableRowBasic(
                      tableHead: Text(
                        'Time',
                        style: textStyleTableCellChild,
                      ),
                      tableCell: Text(
                        enrolledStudent.attendStudent.time.toLocal().toString(),
                        textAlign: TextAlign.end,
                        style: textStyleTableCellChild,
                      ),
                    ),
                  ],
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Out', style: textStyleTableHead),
                tableCell: Table(
                  border: TableBorder.all(color: greyColor3, width: 1, style: BorderStyle.solid),
                  children: [
                    _tableRowBasic(
                      tableHead: Text(
                        'Status (photo)',
                        style: textStyleTableCellChild,
                      ),
                      tableCell: Text(
                        enrolledStudent.outStudent.image,
                        textAlign: TextAlign.end,
                        style: textStyleTableCellChild,
                      ),
                    ),
                    _tableRowBasic(
                      tableHead: Text(
                        'Status (distance)',
                        style: textStyleTableCellChild,
                      ),
                      tableCell: Text(
                        enrolledStudent.statusAttendance.byDistance + '(' + enrolledStudent.outStudent.distance.toStringAsFixed(2) + ')',
                        textAlign: TextAlign.end,
                        style: textStyleTableCellChild,
                      ),
                    ),
                    _tableRowBasic(
                      tableHead: Text(
                        'Time',
                        style: textStyleTableCellChild,
                      ),
                      tableCell: Text(
                        enrolledStudent.attendStudent.time.toLocal().toString(),
                        textAlign: TextAlign.end,
                        style: textStyleTableCellChild,
                      ),
                    ),
                  ],
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Permission', style: textStyleTableHead),
                tableCell: Table(
                  border: TableBorder.all(color: greyColor3, width: 1, style: BorderStyle.solid),
                  children: [
                    _tableRowBasic(
                      tableHead: Text(
                        'Status',
                        style: textStyleTableCellChild,
                      ),
                      tableCell: Text(
                        enrolledStudent.permission.statusPermission,
                        textAlign: TextAlign.end,
                        style: textStyleTableCellChild,
                      ),
                    ),
                    _tableRowBasic(
                      tableHead: Text(
                        'Reason',
                        style: textStyleTableCellChild,
                      ),
                      tableCell: Text(
                        enrolledStudent.permission.reason,
                        textAlign: TextAlign.end,
                        style: textStyleTableCellChild,
                      ),
                    ),
                    _tableRowBasic(
                      tableHead: Text(
                        'Last Update',
                        style: textStyleTableCellChild,
                      ),
                      tableCell: Text(
                        enrolledStudent.permission.datePermission.toLocal().toString(),
                        textAlign: TextAlign.end,
                        style: textStyleTableCellChild,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        print('ON TAP');
      },
    );
  }

  TableRow _tableRowBasic({Widget tableHead, Widget tableCell}) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: tableHead,
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: tableCell,
          ),
        ),
      ],
    );
  }
}
