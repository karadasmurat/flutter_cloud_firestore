import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
          const Text("Please verify your email."),
          TextButton(
              onPressed: () async {
                // note that onPressed callback is async
                User? user = FirebaseAuth.instance.currentUser;
                print(user ?? "Not Logged In.");
                await user?.sendEmailVerification();
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
