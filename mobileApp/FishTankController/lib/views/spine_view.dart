import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpineView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SpinKitFadingCircle(
          color: Colors.green,
          size: 70.0,
        ),
      ),
    );
  }
}
