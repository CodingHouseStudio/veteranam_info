import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
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
    MockSpec<firebase_auth.FirebaseAuth>(),
    MockSpec<IWorkRepository>(),
    MockSpec<FirebaseFirestore>(),
    MockSpec<FlutterSecureStorage>(),
    MockSpec<CacheClient>(),
    MockSpec<firebase_auth.GoogleAuthProvider>(),
    MockSpec<firebase_auth.UserCredential>(),
    MockSpec<firebase_auth.User>(),
    MockSpec<GoogleSignInAccount>(),
    MockSpec<GoogleSignInAuthentication>(),
    MockSpec<CollectionReference>(),
    MockSpec<DocumentReference>(),
    MockSpec<QuerySnapshot>(),
    MockSpec<QueryDocumentSnapshot>(),
    MockSpec<DocumentSnapshot>(),
    MockSpec<DocumentChange>(),
    MockSpec<SnapshotMetadata>(),
    MockSpec<IStoryRepository>(),
    MockSpec<FirebaseStorage>(),
    MockSpec<StorageService>(),
    MockSpec<ImagePicker>(),
    MockSpec<Reference>(),
    MockSpec<UploadTask>(),
    MockSpec<TaskSnapshot>(),
    MockSpec<XFile>(),
    MockSpec<IDiscountRepository>(),
    MockSpec<Query>(),
    MockSpec<HttpClient>(),
    MockSpec<HttpClientRequest>(),
    MockSpec<HttpClientResponse>(),
    MockSpec<HttpHeaders>(),
    MockSpec<IReportRepository>(),
  ],
)
void load() => debugPrint('loaded');
