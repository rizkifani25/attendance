import 'package:attendance/constant/Constant.dart';
import 'package:attendance/models/models.dart';
import 'package:attendance/ui/view/Widgets/custom_dialog.dart';
import 'package:attendance/ui/view/Widgets/table_row_basic.dart';
import 'package:flutter/material.dart';

class LecturerHistoryCard extends StatelessWidget {
  final RoomDetail roomDetail;
  final Time time;

  LecturerHistoryCard({this.roomDetail, this.time});

  _handleTapDetail({
    BuildContext parentContext,
  }) {
    TextStyle textStyleTableHead = TextStyle(fontSize: 13, fontWeight: FontWeight.bold);
    TextStyle textStyleTableCell = TextStyle(fontSize: 13);
    TextStyle textStyleTableCellChild = TextStyle(fontSize: 13);

    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return CustomDialogBox(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.all(3),
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

    return InkWell(
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
