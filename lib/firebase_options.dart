// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyBSZ6clS0Iw7WGHAtvwkR0J38kEKOtcFVg',
    appId: '1:699428334454:web:f1eb2ebf32c2990cefa857',
    messagingSenderId: '699428334454',
    projectId: 'appdev-newsapp-2025',
    authDomain: 'appdev-newsapp-2025.firebaseapp.com',
    storageBucket: 'appdev-newsapp-2025.firebasestorage.app',
    measurementId: 'G-RKKMREWYKW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCsbIgxNhz0lVNplSH4o7gfGfehmQOwy1c',
    appId: '1:699428334454:android:90167bc815e33a15efa857',
    messagingSenderId: '699428334454',
    projectId: 'appdev-newsapp-2025',
    storageBucket: 'appdev-newsapp-2025.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9JuEOEi3dlQ_cnWpiXMUekLzvQ14SQPs',
    appId: '1:699428334454:ios:354177494a80f592efa857',
    messagingSenderId: '699428334454',
    projectId: 'appdev-newsapp-2025',
    storageBucket: 'appdev-newsapp-2025.firebasestorage.app',
    iosBundleId: 'com.example.newsapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA9JuEOEi3dlQ_cnWpiXMUekLzvQ14SQPs',
    appId: '1:699428334454:ios:354177494a80f592efa857',
    messagingSenderId: '699428334454',
    projectId: 'appdev-newsapp-2025',
    storageBucket: 'appdev-newsapp-2025.firebasestorage.app',
    iosBundleId: 'com.example.newsapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBSZ6clS0Iw7WGHAtvwkR0J38kEKOtcFVg',
    appId: '1:699428334454:web:c206dd4bce59ab5cefa857',
    messagingSenderId: '699428334454',
    projectId: 'appdev-newsapp-2025',
    authDomain: 'appdev-newsapp-2025.firebaseapp.com',
    storageBucket: 'appdev-newsapp-2025.firebasestorage.app',
    measurementId: 'G-DTHLK23K71',
  );
}
