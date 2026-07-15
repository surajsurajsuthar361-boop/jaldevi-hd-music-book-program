
// Based on the Firebase configuration from README.md
// IMPORTANT: Replace the placeholder values with your actual Firebase project configuration.

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
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIza....", // Replace with your web API key
    appId: "1:...", // Replace with your web App ID
    messagingSenderId: "...", // Replace with your messaging sender ID
    projectId: "your-project", // Replace with your project ID
    authDomain: "your-project.firebaseapp.com", // Replace with your auth domain
    storageBucket: "your-project.appspot.com", // Replace with your storage bucket
    measurementId: "G-...", // Replace with your measurement ID
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIza....", // Replace with your Android API key
    appId: "1:...", // Replace with your Android App ID
    messagingSenderId: "...", // Replace with your messaging sender ID
    projectId: "your-project", // Replace with your project ID
    storageBucket: "your-project.appspot.com", // Replace with your storage bucket
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIza....", // Replace with your iOS API key
    appId: "1:...", // Replace with your iOS App ID
    messagingSenderId: "...", // Replace with your messaging sender ID
    projectId: "your-project", // Replace with your project ID
    storageBucket: "your-project.appspot.com", // Replace with your storage bucket
    iosBundleId: 'com.example.adminPanel', // Replace with your iOS bundle ID
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "AIza....", // Replace with your macOS API key
    appId: "1:...", // Replace with your macOS App ID
    messagingSenderId: "...", // Replace with your messaging sender ID
    projectId: "your-project", // Replace with your project ID
    storageBucket: "your-project.appspot.com", // Replace with your storage bucket
    iosBundleId: 'com.example.adminPanel', // Replace with your macOS bundle ID
  );
}
