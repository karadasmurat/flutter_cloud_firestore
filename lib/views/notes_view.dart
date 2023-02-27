import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import '../constants/routes.dart';

// This is the type used by the popup menu below.
enum Menu { itemOne, itemTwo, itemThree, logout }

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('My Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          PopupMenuButton(
            onSelected: (menu) {
              dev.log("Selection: $menu");
              if (menu == Menu.logout) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Leaving'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context, 'OK');
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, ROUTE_LOGIN, (route) => false);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem<Menu>(
                value: Menu.itemOne,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Item 1'),
                ),
              ),
              const PopupMenuItem<Menu>(
                value: Menu.itemTwo,
                child: ListTile(
                  leading: Icon(Icons.timeline),
                  title: Text('Item 2'),
                ),
              ),
              const PopupMenuItem<Menu>(
                value: Menu.itemThree,
                child: ListTile(
                  leading: Icon(Icons.abc),
                  title: Text('Item 3'),
                ),
              ),
              const PopupMenuItem<Menu>(
                value: Menu.logout,
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Log out'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
