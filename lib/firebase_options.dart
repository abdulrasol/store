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
        return windows;
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
    apiKey: 'AIzaSyBkrtoUkVUlC5S9ehiDhRNBWoINSkQ5IA8',
    appId: '1:34195937403:web:f9b047e210c6cb67b3aade',
    messagingSenderId: '34195937403',
    projectId: 'grocery-store-9c60a',
    authDomain: 'grocery-store-9c60a.firebaseapp.com',
    storageBucket: 'grocery-store-9c60a.appspot.com',
    measurementId: 'G-4GKMHE7CT4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXfmlbna47nopgjA43mdx8r09Ie0mqH40',
    appId: '1:34195937403:android:471a27b544f57687b3aade',
    messagingSenderId: '34195937403',
    projectId: 'grocery-store-9c60a',
    storageBucket: 'grocery-store-9c60a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCj4Vx5OL2J78v75591w2jaGCoK_BQMnc8',
    appId: '1:34195937403:ios:5b685f67baf6cc32b3aade',
    messagingSenderId: '34195937403',
    projectId: 'grocery-store-9c60a',
    storageBucket: 'grocery-store-9c60a.appspot.com',
    androidClientId: '34195937403-u622tvpbh0of9lm4orh6neui7hk7iokf.apps.googleusercontent.com',
    iosClientId: '34195937403-3tj2ev66fq2vthadt3p4okc80kdeubk7.apps.googleusercontent.com',
    iosBundleId: 'io.github.dot.store.store',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCj4Vx5OL2J78v75591w2jaGCoK_BQMnc8',
    appId: '1:34195937403:ios:5b685f67baf6cc32b3aade',
    messagingSenderId: '34195937403',
    projectId: 'grocery-store-9c60a',
    storageBucket: 'grocery-store-9c60a.appspot.com',
    androidClientId: '34195937403-u622tvpbh0of9lm4orh6neui7hk7iokf.apps.googleusercontent.com',
    iosClientId: '34195937403-3tj2ev66fq2vthadt3p4okc80kdeubk7.apps.googleusercontent.com',
    iosBundleId: 'io.github.dot.store.store',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAjhQxdrVH9bE-eMDTt5SERHyBCcdG_fbA',
    appId: '1:34195937403:web:5b95c81ddbfe8275b3aade',
    messagingSenderId: '34195937403',
    projectId: 'grocery-store-9c60a',
    authDomain: 'grocery-store-9c60a.firebaseapp.com',
    storageBucket: 'grocery-store-9c60a.appspot.com',
    measurementId: 'G-HJD8RQ4JGM',
  );

}