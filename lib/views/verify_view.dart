import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cloud_firestore/services/auth/authservice.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email")),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
              "Thank you for signing up! \nPlease click Verify Now, and then check your mailbox: \n${FirebaseAuth.instance.currentUser?.email}"),
          ElevatedButton(
              onPressed: () async {
                // note that onPressed callback is async

                // OLD
                // final user = FirebaseAuth.instance.currentUser;
                // await user?.sendEmailVerification();

                final authService = AuthService.firebase();
                await authService.sendEmailVerification();
              },
              child: const Text("Verify Now")),
          TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, "/notes", (_) => false);
              },
              child: const Text("Continue to Notes")),
        ]),
      ),
    );
  }
}
