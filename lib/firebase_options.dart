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
        return macos;
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
    apiKey: 'AIzaSyDbWGQwwwK0c8o-m35oVOpFMsHcA-RdFiQ',
    appId: '1:154197803287:web:df6493435c10ec7fceb752',
    messagingSenderId: '154197803287',
    projectId: 'ibnziad-96d87',
    authDomain: 'ibnziad-96d87.firebaseapp.com',
    storageBucket: 'ibnziad-96d87.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACN8doXcI475edrY3cjx6wSQgy9aGGFZU',
    appId: '1:154197803287:android:4de138f4781cd21aceb752',
    messagingSenderId: '154197803287',
    projectId: 'ibnziad-96d87',
    storageBucket: 'ibnziad-96d87.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZHZ_QzcfCzr4pcjs4D4njt8VP3ICg5Pw',
    appId: '1:154197803287:ios:7258a1496e4dc80eceb752',
    messagingSenderId: '154197803287',
    projectId: 'ibnziad-96d87',
    storageBucket: 'ibnziad-96d87.appspot.com',
    iosBundleId: 'com.example.ibnziad',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCZHZ_QzcfCzr4pcjs4D4njt8VP3ICg5Pw',
    appId: '1:154197803287:ios:7258a1496e4dc80eceb752',
    messagingSenderId: '154197803287',
    projectId: 'ibnziad-96d87',
    storageBucket: 'ibnziad-96d87.appspot.com',
    iosBundleId: 'com.example.ibnziad',
  );
}
