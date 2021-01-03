import 'package:attendance/constant/Constant.dart';
import 'package:attendance/models/attend_student.dart';
import 'package:attendance/models/models.dart';
import 'package:attendance/ui/logic/service/service.dart';
import 'package:attendance/ui/view/Widgets/table_row_basic.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AttendOutInfo extends StatelessWidget {
  final AttendStudent attendStudent;
  final OutStudent outStudent;

  AttendOutInfo({this.attendStudent, this.outStudent});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleTableHead = TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: primaryColor);
    TextStyle textStyleTableCell = TextStyle(fontSize: 13);
    return Container(
      padding: EdgeInsets.all(3),
      child: Table(
        border: TableBorder.all(color: greyColor3, width: 1, style: BorderStyle.solid),
        children: [
          TableRowBasic().render(
            tableHead: Text('Time', style: textStyleTableHead),
            tableCell: Text(
              attendStudent != null ? (attendStudent.time.toString() != null ? attendStudent.time.toLocal().toString() : '') : (outStudent.time.toString() != null ? outStudent.time.toLocal().toString() : ''),
              style: textStyleTableCell,
            ),
          ),
          TableRowBasic().render(
            tableHead: Text('Distance', style: textStyleTableHead),
            tableCell: Text(
              attendStudent != null ? attendStudent.distance.toStringAsFixed(2) ?? '' : outStudent.distance.toStringAsFixed(2) ?? '',
              style: textStyleTableCell,
            ),
          ),
          TableRowBasic().render(
            tableHead: Text('Position', style: textStyleTableHead),
            tableCell: Table(
              children: [
                TableRowBasic().render(
                  tableHead: Text('Latitude', style: textStyleTableHead),
                  tableCell: Text(
                    attendStudent != null ? attendStudent.positionStudent.latitude.toString() ?? '' : outStudent.positionStudent.latitude.toString() ?? '',
                    style: textStyleTableCell,
                  ),
                ),
                TableRowBasic().render(
                  tableHead: Text('Longitude', style: textStyleTableHead),
                  tableCell: Text(
                    attendStudent != null ? attendStudent.positionStudent.longitude.toString() ?? '' : outStudent.positionStudent.longitude.toString() ?? '',
                    style: textStyleTableCell,
                  ),
                ),
              ],
            ),
          ),
          TableRowBasic().render(
            tableHead: Text('Image', style: textStyleTableHead),
            tableCell: Container(
              height: 300,
              width: 300,
              margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: FutureBuilder(
                future: _getImage(context, attendStudent != null ? attendStudent.image : outStudent.image),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                    return Container(
                      height: MediaQuery.of(context).size.height / 1.25,
                      width: MediaQuery.of(context).size.width / 1.25,
                      child: snapshot.data,
                    );

                  if (snapshot.connectionState == ConnectionState.waiting) return Container(height: MediaQuery.of(context).size.height / 1.25, width: MediaQuery.of(context).size.width / 1.25, child: CircularProgressIndicator());

                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Widget> _getImage(BuildContext context, String image) async {
    Widget m;
    await Firebase.initializeApp().whenComplete(() {
      print("completed");
    });
    if (image != '') {
      await FireBaseStorageService.loadImage(context, image).then((downloadUrl) {
        m = Image.network(
          downloadUrl.toString(),
          fit: BoxFit.contain,
        );
      }).catchError((onError) {
        m = Text('Image not found');
      });
    } else {
      m = Text('Image not found');
    }

    return m;
  }
}
