import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WidgetLoadingIndicator extends StatelessWidget {
  final Color color;
  WidgetLoadingIndicator({this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitWave(
        color: color,
        type: SpinKitWaveType.center,
        size: 50,
      ),
    );
  }
}
