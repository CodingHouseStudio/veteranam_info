import 'package:cloud_functions/cloud_functions.dart' show FirebaseFunctions;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart'
    show FacebookAuth;
import 'package:google_sign_in/google_sign_in.dart' show GoogleSignIn;
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  @singleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @singleton
  GoogleSignIn get googleSignIn => GoogleSignIn.instance;

  @singleton
  FacebookAuth get firebaseSignIn => FacebookAuth.instance;

  @singleton
  FirebaseFunctions get firebaseFunctions => FirebaseFunctions.instanceFor(
        app: Firebase.app(),
        region: 'us-central1',
      );
}
