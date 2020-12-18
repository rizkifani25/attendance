import 'package:flutter/material.dart';

class TableRowBasic {
  TableRow render({Widget tableHead, Widget tableCell}) {
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
