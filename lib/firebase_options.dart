// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA6siaHBZQCrQXmQMkIAJEs3fwiv4mXZ4g',
    appId: '1:41719632162:web:7738893db8d4a776ff557b',
    messagingSenderId: '41719632162',
    projectId: 'flutter-cloud-firestore-1a335',
    authDomain: 'flutter-cloud-firestore-1a335.firebaseapp.com',
    storageBucket: 'flutter-cloud-firestore-1a335.appspot.com',
    measurementId: 'G-94LT1WRHGG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqkZObo2lmsMLGpk4Wq372RYcCqr_GP7k',
    appId: '1:41719632162:android:88fc890ac5a3c2b0ff557b',
    messagingSenderId: '41719632162',
    projectId: 'flutter-cloud-firestore-1a335',
    storageBucket: 'flutter-cloud-firestore-1a335.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXd3U9MYwDKqRNB5a-DIvFSWgxh2POUZc',
    appId: '1:41719632162:ios:88f2a05a229988b4ff557b',
    messagingSenderId: '41719632162',
    projectId: 'flutter-cloud-firestore-1a335',
    storageBucket: 'flutter-cloud-firestore-1a335.appspot.com',
    iosClientId: '41719632162-l2d830f6t0mis6jprnsov3pc3fbqcef4.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterCloudFirestore',
  );
}
