import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sizer/sizer.dart';

class LoadingProgress extends StatefulWidget {
  @override
  _LoadingProgressState createState() => _LoadingProgressState();
}

class _LoadingProgressState extends State<LoadingProgress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: JumpingDotsProgressIndicator(
        fontSize: 50.0.sp,
      )),
    );
  }
}
