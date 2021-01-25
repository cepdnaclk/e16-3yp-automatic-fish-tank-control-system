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
