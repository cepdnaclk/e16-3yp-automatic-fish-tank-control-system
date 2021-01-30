import 'package:flutter/material.dart';
import 'package:sidebar/background/background.dart';

import 'fish.dart';

class FishDetailView extends StatelessWidget {
  final List<String> fishnames;
  final List<int> fishcount;

  FishDetailView({@required this.fishnames, @required this.fishcount});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.2,
            ),
            ...this.fishWidgets(),
            SizedBox(
              height: 23,
            ),
            RaisedButton(
              elevation: 10.0,
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.3, vertical: 10),
              color: Colors.black,
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                "BACK",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )
          ],
        ),
      )),
    );
  }

  List<Widget> fishWidgets() {
    List<Widget> list = [];

    for (int i = 0; i < this.fishnames.length; i++) {
      list.add(Fish(
        fishname: this.fishnames[i],
        fichcount: this.fishcount[i],
      ));
      list.add(
        SizedBox(
          height: 10,
        ),
      );
    }
    return list;
  }
}
