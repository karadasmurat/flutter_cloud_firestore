import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final bool isVerified;

  const AuthUser({this.isVerified = false});

  // redirective constructor
  // there is already a constructor for initializing isVerified
  AuthUser.fromFirebaseUser(fb.User user) : this(isVerified: user.emailVerified);

  // redirective constructor
  AuthUser.fromFirebaseUserCredential(fb.UserCredential userCredential)
      : this(isVerified: userCredential.user?.emailVerified ?? false);

  // initializer list
  // AuthUser.fromFB(fb.User user) : isVerified = user.emailVerified;

  // factory AuthUser.fromFirebase(fb.User user) => AuthUser(user.emailVerified);

  @override
  String toString() {
    // TODO: implement toString
    return "AuthUser(isVerified: $isVerified)";
  }
}
