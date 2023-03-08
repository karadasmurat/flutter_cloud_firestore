// Custom Auth exceptions

// No that we cannot extend Exception as it only has factory constructor (no generative constructors)
class AuthException implements Exception {
  final String? msg;

  AuthException([this.msg]); // Positional Optional Parameter

  @override
  String toString() {
    return msg == null ? "AuthException" : "Exception: $msg";
  }
}

// signIn
class UserNotFoundAuthException extends AuthException {
  UserNotFoundAuthException([String? msg]) : super(msg);
}

class WrongPasswordAuthException extends AuthException {
  WrongPasswordAuthException([String? msg]) : super(msg);
}

// register
class WeakPasswordAuthException extends AuthException {
  WeakPasswordAuthException([String? msg]) : super(msg);
}

class EmailAlreadyInUseAuthException extends AuthException {
  EmailAlreadyInUseAuthException([String? msg]) : super(msg);
}

class InvalidEmailAuthException extends AuthException {
  InvalidEmailAuthException([String? msg]) : super(msg);
}

// generic exceptions
class GenericAuthException extends AuthException {
  GenericAuthException([String? msg]) : super(msg);
}

class UserNotLoggedInAuthException extends AuthException {
  UserNotLoggedInAuthException([String? msg]) : super(msg);
}
