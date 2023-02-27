import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/routes.dart';
import '../util/err_dialog.dart';

import '../dart/async.dart';

import 'dart:developer' as dev;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // initstate
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late Future<String> _value;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _value = getValue();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: "Enter your email here."),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: "Enter your password here."),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final userCredential =
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    //print('The password provided is too weak.');
                    await errDialog(context, e.message ?? e.code);
                  } else if (e.code == 'email-already-in-use') {
                    //print('The account already exists for that email.');
                    await errDialog(context, e.message ?? e.code);
                  }
                } catch (e) {
                  dev.log(e.toString());
                }
              },
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(context, ROUTE_LOGIN);
              },
              child: const Text("Already Registered? Sign In Here."),
            ),
          ],
        ),
      ),
    );
  }

  void onPressed() {
    print("Button pressed.");
  }
}
