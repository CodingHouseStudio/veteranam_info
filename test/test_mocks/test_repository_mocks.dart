import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks(
  [
    MockSpec<IHomeRepository>(),
    MockSpec<IInformationRepository>(),
    MockSpec<IFeedbackRepository>(),
    MockSpec<FirestoreService>(),
    MockSpec<IAppAuthenticationRepository>(),
    MockSpec<AppAuthenticationRepository>(),
    MockSpec<AuthenticationRepository>(),
    MockSpec<IStorage>(),
    MockSpec<GoogleSignIn>(),
    MockSpec<FirebaseAuth>(),
  ],
)
void load() => debugPrint('loaded');
