import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class StreamBuilderDemo extends StatefulWidget {
  const StreamBuilderDemo({Key? key}) : super(key: key);

  @override
  State<StreamBuilderDemo> createState() => _StreamBuilderDemoState();
}

class _StreamBuilderDemoState extends State<StreamBuilderDemo> {
  //StreamBuilder's stream variable:
  late Stream<int?> _stream;

  Stream<int?> getData() async* {
    for (var i = 0; i < 5; i++) {
      await Future.delayed(const Duration(seconds: 2));
      yield Random().nextInt(100);
    }
  }

  @override
  void initState() {
    super.initState();

    _stream = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("StreamBuilder Demo")),
      body: Center(
          child: StreamBuilder<int?>(
        stream: _stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              if (snapshot.hasData) {
                int? data = snapshot.data;
                return Text("We have data: $data");
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return Row(children: [
                  Icon(Icons.info, color: Colors.blueAccent),
                  Text("No data."),
                ]);
              }

            case ConnectionState.done:
              return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.info, color: Colors.blueAccent),
                Text("Stream is done."),
              ]);

            default:
              return CircularProgressIndicator();
          }
        },
      )),
    );
  }
}
