/*
The goal of a unit test is to verify the correctness of a unit of logic under a variety of conditions. 
External dependencies of the unit under test are generally mocked out. 
Unit tests generally don’t read from or write to disk, render to screen, or receive user actions from outside the process running the test. 

test package provides the core functionality for writing tests in Dart:

  dev_dependencies:
    test: <latest_version>


Run tests:
VSCode - click Run over the main() method.
$ flutter test test/auth_test.dart 

 */
import 'package:flutter_cloud_firestore/services/auth/authexceptions.dart';
import 'package:flutter_cloud_firestore/services/auth/authprovider.dart';
import 'package:flutter_cloud_firestore/services/auth/authuser.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();

    test('Should not be initialized to begin with', () {
      expect(provider.initialized, false);
    });

    test(
      'Should be able to initialize in less than 3 seconds',
      () async {
        await provider.initialize();
        expect(provider.initialized, true);
      },
      timeout: const Timeout(Duration(seconds: 3)),
    );
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;

  bool get initialized => _isInitialized;

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> createUser({required String email, required String password}) async {
    if (!initialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return signIn(email: email, password: password);
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> sendEmailVerification() async {
    if (!initialized) throw NotInitializedException();

    await Future.delayed(const Duration(seconds: 1));

    if (_user == null) throw UserNotFoundAuthException();
    const auser = AuthUser(isVerified: true);
    _user = auser;
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    if (!initialized) throw NotInitializedException();

    await Future.delayed(const Duration(seconds: 1));

    if (email == "nf@test.com") throw UserNotFoundAuthException();
    if (password == "wp") throw WrongPasswordAuthException();
    const auser = AuthUser();
    _user = auser;
    return auser;
  }

  @override
  Future<AuthUser> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    if (!initialized) throw NotInitializedException();

    await Future.delayed(const Duration(seconds: 1));

    if (_user == null) throw UserNotFoundAuthException();
    _user = null;
  }
}
