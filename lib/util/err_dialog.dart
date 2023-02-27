import 'package:flutter/material.dart';

Future<void> errDialog(BuildContext context, String content) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      //title: Text(title),
      title: const Icon(Icons.error, size: 40.0),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'OK');
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
