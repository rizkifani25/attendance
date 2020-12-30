import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

typedef OnSelectedDate = void Function(String date);

class Calendar extends StatelessWidget {
  final OnSelectedDate onSelectedDate;

  Calendar({this.onSelectedDate});

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    DateTime dateNow = args.value;
    if (args.value is DateTime) {
      if (dateNow != DateTime.now()) onSelectedDate(DateFormat('yyyy-MM-dd').format(args.value).toString());
      onSelectedDate(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      onSelectionChanged: _onSelectionChanged,
      selectionMode: DateRangePickerSelectionMode.single,
    );
  }
}
