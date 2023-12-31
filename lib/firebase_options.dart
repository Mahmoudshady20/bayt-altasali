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
    apiKey: 'AIzaSyBZquigzfePFhXtNw0Y54TaRagb4zetpHQ',
    appId: '1:531544240111:web:4ae884f910648c73b3101a',
    messagingSenderId: '531544240111',
    projectId: 'funhousestroe',
    authDomain: 'funhousestroe.firebaseapp.com',
    storageBucket: 'funhousestroe.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBE6q5O3trTUbkY51glTcn0myHQelCWjcI',
    appId: '1:531544240111:android:3b3805be92269fbfb3101a',
    messagingSenderId: '531544240111',
    projectId: 'funhousestroe',
    storageBucket: 'funhousestroe.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-ANH6tEc8NHHh3yVq75ibvLrbakcouSc',
    appId: '1:531544240111:ios:b703c6d01b593436b3101a',
    messagingSenderId: '531544240111',
    projectId: 'funhousestroe',
    storageBucket: 'funhousestroe.appspot.com',
    iosBundleId: 'com.example.funHouseStore',
  );
}
