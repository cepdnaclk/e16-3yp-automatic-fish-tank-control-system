import 'package:flutter/material.dart';

class StartingViewButton extends StatelessWidget {
  final String name;
  final Color splash;
  final Color background;
  final Function onPressed;

  StartingViewButton(
      {@required this.name,
      @required this.background,
      @required this.splash,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
          color: this.background,
          onPressed: this.onPressed,
          child: Text(
            this.name,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: this.splash),
          ),
        ),
      ),
    );
  }
}
