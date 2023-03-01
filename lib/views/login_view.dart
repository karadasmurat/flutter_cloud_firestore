import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import '../constants/routes.dart';
import '../util/authentication.dart';
import '../util/err_dialog.dart';

const String kIconGoogleSignIn = 'assets/icons/google.png';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // initstate
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "analyticode@proton.me");
    _passwordController = TextEditingController();
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
        title: const Text('Login'),
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
                  // signInWithEmailAndPassword
                  final userCredential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim());

                  User? user = userCredential.user;

                  dev.log("User Info: $user");

                  if (user?.emailVerified ?? false) {
                    dev.log("E-mail Verified.");
                    // Push the route with the given name onto the navigator, and then remove all the previous routes
                    Navigator.pushNamedAndRemoveUntil(context, ROUTE_NOTES, (_) => false);
                  } else {
                    dev.log("Email not verified.");
                    Navigator.pushNamedAndRemoveUntil(
                        context, ROUTE_VERIFY, (_) => false);
                  }
                } on FirebaseAuthException catch (e) {
                  dev.log('Failed with FirebaseAuthException: ${e.message}');

                  // give different reactions to different errors if required
                  if (e.code == 'user-not-found') {
                    dev.log('USER NOT FOUND custom message.');
                  } else if (e.code == 'wrong-password') {
                    dev.log('WRONG PASSWORD custom message.');
                  } else if (e.code == 'invalid-email') {
                    dev.log('INVALID EMAIL custom message.');
                  }
                  //

                  // Option 1 - Show a [SnackBar]
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.message ?? e.code),
                    ),
                  );

                  // Option 2 - Show a dialog
                  // await errDialog(context, e.message ?? "e.code");
                } catch (e) {
                  dev.log(e.toString());
                }
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () async {
                final userCredential = await Authentication.signInWithGoogle(context);

                if (userCredential != null) {
                  Navigator.pushNamedAndRemoveUntil(context, ROUTE_VERIFY, (_) => false);
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Image(
                      image: AssetImage(kIconGoogleSignIn),
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(context, '/register');
              },
              child: const Text("Sign Up here"),
            ),
            //Text("Current User: ${currUser?.email}"),
          ],
        ),
      ),
    );
  }
}
