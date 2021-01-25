import 'package:flutter/material.dart';

import '../background/background.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Text("More"),
    );
  }
}
