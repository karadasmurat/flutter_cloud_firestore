import 'package:flutter/material.dart';

Future<void> errDialog(BuildContext context, String content) {
  // showDialog function displays a Material dialog above the current contents of the app
  // This function takes a builder which typically builds a Dialog widget.
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
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
