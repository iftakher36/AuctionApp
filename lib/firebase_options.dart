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
    apiKey: 'AIzaSyAgdbeThEjI-2EOimEqFe3TNhtAwjKKpAo',
    appId: '1:214017885313:web:fe9a285e5979d2c59b3980',
    messagingSenderId: '214017885313',
    projectId: 'ostadauctionapp',
    authDomain: 'ostadauctionapp.firebaseapp.com',
    storageBucket: 'ostadauctionapp.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCtu0p12aiK1MDEm_WR7ra9rnazzhg_dFY',
    appId: '1:214017885313:android:77876f08220f16559b3980',
    messagingSenderId: '214017885313',
    projectId: 'ostadauctionapp',
    storageBucket: 'ostadauctionapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAzIEBNZU3rsyv1KXgNd8ik4Mh9wvHlHT0',
    appId: '1:214017885313:ios:da14b890bd8b3d859b3980',
    messagingSenderId: '214017885313',
    projectId: 'ostadauctionapp',
    storageBucket: 'ostadauctionapp.appspot.com',
    iosClientId: '214017885313-gp479f9bpfb1js13khpfmvem3hk4jt5v.apps.googleusercontent.com',
    iosBundleId: 'com.OstadAuctionApp.auctionApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAzIEBNZU3rsyv1KXgNd8ik4Mh9wvHlHT0',
    appId: '1:214017885313:ios:da14b890bd8b3d859b3980',
    messagingSenderId: '214017885313',
    projectId: 'ostadauctionapp',
    storageBucket: 'ostadauctionapp.appspot.com',
    iosClientId: '214017885313-gp479f9bpfb1js13khpfmvem3hk4jt5v.apps.googleusercontent.com',
    iosBundleId: 'com.OstadAuctionApp.auctionApp',
  );
}
