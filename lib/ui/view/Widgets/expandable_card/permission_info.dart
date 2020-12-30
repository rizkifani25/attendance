import 'package:attendance/constant/Constant.dart';
import 'package:attendance/models/models.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/view/Widgets/table_row_basic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermissionInfo extends StatefulWidget {
  final Permission permission;
  final String roomId;
  final String studentId;
  final String time;

  PermissionInfo({this.permission, this.roomId, this.studentId, this.time});

  @override
  _PermissionInfoState createState() => _PermissionInfoState();
}

class _PermissionInfoState extends State<PermissionInfo> {
  String selectedStatus;
  TextStyle textStyleTableHead = TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: primaryColor);
  TextStyle textStyleTableCell = TextStyle(fontSize: 13);

  @override
  void initState() {
    selectedStatus = widget.permission.statusPermission;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      child: Table(
        border: TableBorder.all(color: greyColor3, width: 1, style: BorderStyle.solid),
        children: [
          TableRowBasic().render(
            tableHead: Text('Reason', style: textStyleTableHead),
            tableCell: Text(widget.permission.reason, style: textStyleTableCell),
          ),
          TableRowBasic().render(
            tableHead: Text('Approval Status', style: textStyleTableHead),
            tableCell: DropdownButton(
              value: selectedStatus,
              items: Permission().getStatusPermission().map((e) {
                return DropdownMenuItem(
                  child: Text(e.statusPermission),
                  value: e.statusPermission,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedStatus = value;
                });

                BlocProvider.of<StudentBloc>(context).add(
                  StudentDoPermission(
                    permission: new Permission(
                      statusPermission: selectedStatus,
                      reason: widget.permission.reason,
                      datePermission: widget.permission.datePermission,
                    ),
                    roomId: widget.roomId,
                    studentId: widget.studentId,
                    time: widget.time,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
