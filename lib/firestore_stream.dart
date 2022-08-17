import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreStreamDemo extends StatefulWidget {
  const FirestoreStreamDemo({Key? key}) : super(key: key);

  @override
  State<FirestoreStreamDemo> createState() => _FirestoreStreamDemoState();
}

class _FirestoreStreamDemoState extends State<FirestoreStreamDemo> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _carsStream;

  @override
  void initState() {
    super.initState();

    _carsStream = FirebaseFirestore.instance.collection('cars').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Firestore Stream Demo")),
      body: Center(
          child: StreamBuilder<QuerySnapshot>(
        stream: _carsStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              if (snapshot.hasData) {
                var docs = snapshot.data!.docs; //snapshot has data
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index].data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data["make"]),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return Text("No data.");
              }
            case ConnectionState.done:
              // TODO: Handle this case.
              return Text("Stream is done.");

            default:
              return CircularProgressIndicator();
          }
        },
      )),
    );
  }
}
