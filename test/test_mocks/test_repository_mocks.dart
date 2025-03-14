import 'dart:developer' show log;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veteranam/shared/shared_dart.dart';

@GenerateNiceMocks(
  [
    MockSpec<IFaqRepository>(),
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
    MockSpec<IUrlRepository>(),
    MockSpec<NetworkRepository>(),
    MockSpec<IAppNetworkRepository>(),
    MockSpec<Connectivity>(),
    MockSpec<FirebaseAnalyticsService>(),
    MockSpec<FirebaseAnalytics>(),
    MockSpec<FirebaseRemoteConfigProvider>(),
    MockSpec<FirebaseRemoteConfig>(),
    MockSpec<FirebaseMessaging>(),
    MockSpec<IDeviceRepository>(),
    MockSpec<AppInfoRepository>(),
    MockSpec<DeviceInfoPlugin>(),
    // MockSpec<FirebaseCrashlytics>(),
    MockSpec<FailureRepository>(),
    MockSpec<FacebookAuth>(),
    MockSpec<LoginResult>(),
    MockSpec<firebase_auth.FacebookAuthProvider>(),
    MockSpec<ICitiesRepository>(),
    MockSpec<ICompanyRepository>(),
    MockSpec<IDataPickerRepository>(),
    MockSpec<FilePicker>(),
    MockSpec<FilePickerResult>(),
    MockSpec<PlatformFile>(),
    MockSpec<MobileRatingRepository>(),
    MockSpec<InAppReview>(),
    MockSpec<UserRepository>(),
    MockSpec<IDiscountFilterRepository>(),
    MockSpec<IAppLayoutRepository>(),
    MockSpec<SharedPrefencesProvider>(),
    MockSpec<SharedPreferences>(),
    MockSpec<ICompanyCacheRepository>(),
    MockSpec<ILanguageCacheRepository>(),
    MockSpec<WidgetsBinding>(),
    MockSpec<firebase_auth.AppleAuthProvider>(),
  ],
)
void load() => log('loaded', name: 'Test', sequenceNumber: -2);
