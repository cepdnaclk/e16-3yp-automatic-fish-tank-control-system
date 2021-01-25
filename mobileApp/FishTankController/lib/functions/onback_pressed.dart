import 'package:flutter/material.dart';

Future<bool> onBackPressed(BuildContext context) {
  return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to log out..'),
          actions: <Widget>[
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text(
                "NO",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(true),
              child: Text("YES",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ),
      ) ??
      false;
}
