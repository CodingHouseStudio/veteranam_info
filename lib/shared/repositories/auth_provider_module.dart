import 'package:firebase_auth/firebase_auth.dart'
    show
        AppleAuthProvider,
        AuthCredential,
        FacebookAuthProvider,
        GoogleAuthProvider;

import 'package:injectable/injectable.dart';

@module
abstract class AuthProviderModule {
  @singleton
  FacebookAuthProvider get firebaseAuth => FacebookAuthProvider();

  @singleton
  GoogleAuthProvider get googleSignIn => GoogleAuthProvider();

  @singleton
  AppleAuthProvider get appleAuthProvider => AppleAuthProvider();
}
