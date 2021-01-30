import 'package:flutter/material.dart';

alertMessage(BuildContext context, String topic, String message) {
  var alert = AlertDialog(
    title: Text(topic),
    content: Text(message),
    actions: [
      TextButton(
          child: Text(
            'OK',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          })
    ],
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return alert;
    },
  );
}


Future<bool> logoutAlertMessage(BuildContext context,String topic, String message) {
  return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(topic),
          content: new Text(message),
          actions: <Widget>[
            SizedBox(height: 16),
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(true),
              child: Text("OK",
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
