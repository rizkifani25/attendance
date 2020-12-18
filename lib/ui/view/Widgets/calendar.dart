import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

typedef OnSelectedDate = void Function(String date);

class Calendar extends StatefulWidget {
  final OnSelectedDate onSelectedDate;

  Calendar({this.onSelectedDate});

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // if (args.value is DateTime) {
    widget.onSelectedDate(DateFormat('yyyy-MM-dd').format(args.value).toString());
    // }

    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    // setState(() {
    //   _selectedDate = args.value;
    // if (args.value is PickerDateRange) {
    //   _range = DateFormat('yyyy-MM-dd').format(args.value.startDate).toString() +
    //       ' - ' +
    //       DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate).toString();
    // } else if (args.value is DateTime) {
    //   _selectedDate = args.value;
    // } else if (args.value is List<DateTime>) {
    //   _dateCount = args.value.length.toString();
    // } else {
    //   _rangeCount = args.value.length.toString();
    // }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      onSelectionChanged: _onSelectionChanged,
      selectionMode: DateRangePickerSelectionMode.single,
      initialSelectedRange: PickerDateRange(
        DateTime.now().subtract(const Duration(days: 4)),
        DateTime.now().add(const Duration(days: 3)),
      ),
    );
  }
}
