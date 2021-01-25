import 'package:flutter/material.dart';

import '../background/background.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Text("hello"),
    );
  }
}
