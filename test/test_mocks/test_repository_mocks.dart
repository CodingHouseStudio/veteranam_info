import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks(
  [
    MockSpec<IHomeRepository>(),
    MockSpec<IInformationRepository>(),
    MockSpec<IFeedbackRepository>(),
    MockSpec<FirestoreService>(),
    MockSpec<IInvestorsRepository>(),
    MockSpec<IAppAuthenticationRepository>(),
    MockSpec<AppAuthenticationRepository>(),
    MockSpec<AuthenticationRepository>(),
    MockSpec<IStorage>(),
    MockSpec<GoogleSignIn>(),
    MockSpec<FirebaseAuth>(),
    MockSpec<IWorkRepository>(),
    MockSpec<FlutterSecureStorage>(),
  ],
)
void load() => debugPrint('loaded');
