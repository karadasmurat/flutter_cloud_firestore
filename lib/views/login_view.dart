import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import '../constants/routes.dart';
import '../services/auth/authexceptions.dart';
import '../services/auth/authservice.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () async {
                    // OLD
                    // await FirebaseAuth.instance.sendPasswordResetEmail(
                    //   email: _emailController.text.trim(),
                    // );

                    final authService = AuthService.firebase();
                    await authService.sendPasswordResetEmail(
                        email: _emailController.text.trim());

                    // Navigate to the second screen using a named route.
                    Navigator.pushNamedAndRemoveUntil(context, ROUTE_LOGIN, (_) => false);
                  },
                  child: const Text("Forgot Password?"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // OLD
                      // final userCredential =
                      //     await FirebaseAuth.instance.signInWithEmailAndPassword(
                      //   email: _emailController.text.trim(),
                      //   password: _passwordController.text.trim(),
                      // );

                      // User? user = userCredential.user;

                      final authService = AuthService.firebase();
                      final auser = await authService.signIn(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );

                      if (authService.currentUser != null) {
                        if (authService.currentUser?.isVerified ?? false) {
                          dev.log("E-mail Verified.");
                          // Push the route with the given name onto the navigator, and then remove all the previous routes
                          Navigator.pushNamedAndRemoveUntil(
                              context, ROUTE_NOTES, (_) => false);
                        } else {
                          dev.log("Email not verified.");
                          Navigator.pushNamedAndRemoveUntil(
                              context, ROUTE_VERIFY, (_) => false);
                        }
                      }
                    } on AuthException catch (e) {
                      dev.log("We have a login problem: $e");

                      // Option 1 - Show a [SnackBar]
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                        ),
                      );

                      // Option 2 - Show a dialog
                      // await errDialog(context, e.message ?? "e.code");
                    } catch (e) {
                      dev.log("We have a real error: $e");
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
            TextButton(
              onPressed: () async {
                // OLD
                // final userCredential = await Authentication.signInWithGoogle(context);

                final authService = AuthService.firebase();
                final auser = await authService.signInWithGoogle();

                Navigator.pushNamedAndRemoveUntil(context, ROUTE_VERIFY, (_) => false);
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
