import 'package:firebase_auth/firebase_auth.dart'
    show AuthCredential, FacebookAuthProvider, GoogleAuthProvider;
import 'package:injectable/injectable.dart';

@module
abstract class AuthProviderModule {
  @singleton
  FacebookAuthProvider get firebaseAuth => FacebookAuthProvider();

  @singleton
  GoogleAuthProvider get googleSignIn => GoogleAuthProvider();
}
