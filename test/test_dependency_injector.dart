import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:veteranam/components/discounts/bloc/view_mode/view_mode_cubit.dart';
import 'package:veteranam/components/discounts/bloc/watcher/discounts_watcher_bloc.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart';
import 'package:veteranam/components/mob_faq/bloc/mob_faq_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import 'test_dependency.dart';

/// COMMENT: Method register Services, Repositories and Blocs in tests
void configureDependenciesTest() {
  final FirebaseFirestore mockFirebaseFirestore = MockFirebaseFirestore();
  // register logic if user id empty user setting is also empty
  initializeDateFormatting(Language.english.value.languageCode);
  initializeDateFormatting(Language.ukrain.value.languageCode);
  userSetting(mockFirebaseFirestore);
  discountInit(mockFirebaseFirestore);
  mobBuild();
  Config.testIsWeb = true;
  Config.falvourValue = Config.development;
  Config.roleValue = Config.user;
  KTest.isTest = true;
  Config.isReleaseMode = true;
  MockGoRouter.canPopValue = true;
  ExtendedDateTime.current = KTestVariables.dateTime;

  // KTest.scroll = null;
  // Services
  // GetIt.I.registerSingleton<FirebaseCrashlytics>(MockFirebaseCrashlytics());
  GetIt.I.registerSingleton<FirebaseFirestore>(mockFirebaseFirestore);
  GetIt.I.registerSingleton<Dio>(Dio());
  GetIt.I.registerSingleton<FirebaseAuth>(MockFirebaseAuth());
  GetIt.I.registerSingleton<FlutterSecureStorage>(MockFlutterSecureStorage());
  GetIt.I.registerSingleton<GoogleSignIn>(GoogleSignIn());
  GetIt.I.registerSingleton<GoogleAuthProvider>(MockGoogleAuthProvider());
  GetIt.I.registerSingleton<FacebookAuthProvider>(MockFacebookAuthProvider());
  GetIt.I.registerSingleton<FacebookAuth>(MockFacebookAuth());
  GetIt.I.registerSingleton<FakeClient>(FakeClient());
  GetIt.I.registerSingleton<FirebaseAnalytics>(MockFirebaseAnalytics());
  GetIt.I.registerSingleton<FirebaseRemoteConfig>(MockFirebaseRemoteConfig());
  GetIt.I.registerSingleton<FirebaseMessaging>(MockFirebaseMessaging());
  GetIt.I.registerSingleton<StorageService>(MockStorageService());
  GetIt.I.registerSingleton<Connectivity>(Connectivity());
  GetIt.I.registerSingleton<DeviceInfoPlugin>(DeviceInfoPlugin());
  GetIt.I.registerSingleton<FirestoreService>(
    FirestoreService(
      firebaseFirestore: GetIt.I.get<FirebaseFirestore>(),
      cache: CacheClient(),
    ),
  );
  GetIt.I.registerSingleton<FirebaseRemoteConfigProvider>(
    FirebaseRemoteConfigProvider(
      firebaseRemoteConfig: GetIt.I.get<FirebaseRemoteConfig>(),
    ),
  );
  GetIt.I.registerSingleton<ArtifactDownloadHelper>(
    ArtifactDownloadHelper(
      dio: GetIt.I.get<Dio>(),
    ),
  );

  // Repositories
  GetIt.I.registerLazySingleton<FailureRepository>(
    FailureRepository.new, //GetIt.I.get<FirebaseCrashlytics>()
  );
  GetIt.I.registerSingleton<IStorage>(
    SecureStorageRepository(
      secureStorage: GetIt.I.get<FlutterSecureStorage>(),
    ),
  );
  GetIt.I.registerSingleton<AppInfoRepository>(AppInfoRepository());
  GetIt.I.registerSingleton<IFeedbackRepository>(
    FeedbackRepository(
      firestoreService: GetIt.I.get<FirestoreService>(),
      storageService: GetIt.I.get<StorageService>(),
    ),
  );
  GetIt.I.registerSingleton<IDeviceRepository>(
    DeviceRepository(
      firebaseMessaging: GetIt.I.get<FirebaseMessaging>(),
      deviceInfoPlugin: GetIt.I.get<DeviceInfoPlugin>(),
      buildRepository: GetIt.I.get<AppInfoRepository>(),
    ),
  );
  GetIt.I.registerSingleton<IFaqRepository>(
    FaqRepository(
      firestoreService: GetIt.I.get<FirestoreService>(),
    ),
  );
  GetIt.I.registerSingleton<IAppAuthenticationRepository>(
    AppAuthenticationRepository(
      secureStorageRepository: GetIt.I.get<IStorage>(),
      firebaseAuth: GetIt.I.get<FirebaseAuth>(),
      googleSignIn: GetIt.I.get<GoogleSignIn>(),
      cache: CacheClient(),
      facebookSignIn: GetIt.I.get<FacebookAuth>(),
      deviceRepository: GetIt.I.get<IDeviceRepository>(),
      facebookAuthProvider: GetIt.I.get<FacebookAuthProvider>(),
      firestoreService: GetIt.I.get<FirestoreService>(),
      googleAuthProvider: GetIt.I.get<GoogleAuthProvider>(),
      storageService: GetIt.I.get<StorageService>(),
    ),
  );
  GetIt.I.registerSingleton<AuthenticationRepository>(
    AuthenticationRepository(
      appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>(),
    ),
  );
  GetIt.I.registerSingleton<UserRepository>(
    UserRepository(
      appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>(),
    ),
  );
  GetIt.I.registerSingleton<FirebaseAnalyticsService>(
    FirebaseAnalyticsService(
      firebaseAnalytics: GetIt.I.get<FirebaseAnalytics>(),
      userRepository: GetIt.I.get<UserRepository>(),
    ),
  );
  GetIt.I.registerSingleton<IAppNetworkRepository>(
    AppNetworkRepository(
      connectivity: GetIt.I.get<Connectivity>(),
      cache: CacheClient(),
    ),
  );
  GetIt.I.registerSingleton<IDiscountRepository>(
    DiscountRepository(
      firestoreService: GetIt.I.get<FirestoreService>(),
    ),
  );
  GetIt.I.registerSingleton<IReportRepository>(
    ReportRepository(
      firestoreService: GetIt.I.get<FirestoreService>(),
    ),
  );
  GetIt.I.registerSingleton<IUrlRepository>(UrlRepository());
  GetIt.I.registerSingleton<ICompanyRepository>(
    CompanyRepository(
      appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>(),
      cache: CacheClient(),
      firestoreService: GetIt.I.get<FirestoreService>(),
      storageService: GetIt.I.get<StorageService>(),
    ),
  );
  GetIt.I.registerSingleton<NetworkRepository>(
    NetworkRepository(
      appNetworkRepository: GetIt.I.get<IAppNetworkRepository>(),
    ),
  );
  // GetIt.I.registerSingleton<IInformationRepository>(InformationRepository());
  GetIt.I.registerSingleton<IInvestorsRepository>(
    InvestorsRepository(
      firestoreService: GetIt.I.get<FirestoreService>(),
    ),
  );
  // GetIt.I.registerSingleton<IWorkRepository>(WorkRepository());
  // GetIt.I.registerSingleton<IStoryRepository>(StoryRepository());
  // Blocs
  // GetIt.I.registerSingleton<FeedbackBloc>(
  //   FeedbackBloc(
  //     feedbackRepository: GetIt.I.get<IFeedbackRepository>(),
  //     appAuthenticationRepository: GetIt.I.get
  // <IAppAuthenticationRepository>(),
  //   ),
  // );
  GetIt.I.registerSingleton<HomeWatcherBloc>(
    HomeWatcherBloc(faqRepository: GetIt.I.get<IFaqRepository>()),
  );
  GetIt.I.registerSingleton<MobFaqWatcherBloc>(
    MobFaqWatcherBloc(faqRepository: GetIt.I.get<IFaqRepository>()),
  );
  GetIt.I.registerSingleton<AuthenticationBloc>(
    AuthenticationBloc(
      authenticationRepository: GetIt.I.get<AuthenticationRepository>(),
    ),
  );
  GetIt.I.registerSingleton<UserWatcherBloc>(
    UserWatcherBloc(
      userRepository: GetIt.I.get<UserRepository>(),
    ),
  );
  GetIt.I.registerSingleton<LanguageCubit>(
    LanguageCubit(
      userRepository: GetIt.I.get<UserRepository>(),
    ),
  );
  GetIt.I.registerSingleton<MobOfflineModeCubit>(
    MobOfflineModeCubit(
      firestoreService: GetIt.I.get<FirestoreService>(),
    ),
  );
  GetIt.I.registerSingleton<CompanyWatcherBloc>(
    CompanyWatcherBloc(
      companyRepository: GetIt.I.get<ICompanyRepository>(),
    ),
  );
  // GetIt.I.registerSingleton<LoginBloc>(
  //   LoginBloc(
  //     appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>
  // (),
  //   ),
  // );
  // GetIt.I.registerSingleton<SignUpBloc>(
  //   SignUpBloc(
  //     iAppAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>
  // (),
  //   ),
  // );
  // GetIt.I.registerSingleton<InformationWatcherBloc>(
  //   InformationWatcherBloc(
  //     informationRepository: GetIt.I.get<IInformationRepository>(),
  //   ),
  // );
  GetIt.I.registerSingleton<InvestorsWatcherBloc>(
    InvestorsWatcherBloc(
      investorsRepository: GetIt.I.get<IInvestorsRepository>(),
      // reportRepository: GetIt.I.get<IReportRepository>(),
      // appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>
      // (),
    ),
  );
  // GetIt.I.registerSingleton<WorkEmployeeWatcherBloc>(
  //   WorkEmployeeWatcherBloc(
  //     workRepository: GetIt.I.get<IWorkRepository>(),
  //   ),
  // );
  // GetIt.I.registerSingleton<StoryWatcherBloc>(
  //   StoryWatcherBloc(
  //     storyRepository: GetIt.I.get<IStoryRepository>(),
  //   ),
  // );
  GetIt.I.registerSingleton<DiscountsWatcherBloc>(
    DiscountsWatcherBloc(
      discountRepository: GetIt.I.get<IDiscountRepository>(),
      // appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>
      // (),
      // reportRepository: GetIt.I.get<IReportRepository>(),
      firebaseRemoteConfigProvider: GetIt.I.get<FirebaseRemoteConfigProvider>(),
    ),
  );
  GetIt.I.registerSingleton<UrlCubit>(
    UrlCubit(
      urlRepository: GetIt.I.get<IUrlRepository>(),
    ),
  );
  GetIt.I.registerSingleton<NetworkCubit>(
    NetworkCubit(
      networkRepository: GetIt.I.get<NetworkRepository>(),
    ),
  );
  GetIt.I.registerSingleton<MobFeedbackBloc>(
    MobFeedbackBloc(
      appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>(),
      feedbackRepository: GetIt.I.get<IFeedbackRepository>(),
    ),
  );
  GetIt.I.registerSingleton<ViewModeCubit>(
    ViewModeCubit(),
  );
  // GetIt.I.registerSingleton<MyDiscountsWatcherBloc>(
  //   MyDiscountsWatcherBloc(
  //     discountRepository: GetIt.I.get<IDiscountRepository>(),
  //     iAppAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>
  // (),
  //   ),
  // );
}

void configureFailureDependenciesTest() {
  final FirebaseFirestore mockFirebaseFirestore = MockFirebaseFirestore();
  // register logic if user id empty user setting is also empty
  userSetting(mockFirebaseFirestore);
  initializeDateFormatting(Language.english.value.languageCode);
  initializeDateFormatting(Language.ukrain.value.languageCode);
  Config.testIsWeb = true;
  Config.falvourValue = Config.development;
  KTest.isTest = true;
  Config.isReleaseMode = true;

  ExtendedDateTime.current = KTestVariables.dateTime;
  // KTest.scroll = null;
  // Services
  GetIt.I.registerSingleton<FirebaseFirestore>(mockFirebaseFirestore);
  GetIt.I.registerSingleton<Dio>(Dio());
  // GetIt.I.registerSingleton<FirebaseCrashlytics>(MockFirebaseCrashlytics());
  GetIt.I.registerSingleton<ArtifactDownloadHelper>(
    ArtifactDownloadHelper(
      dio: GetIt.I.get<Dio>(),
    ),
  );

  // Repositories
  GetIt.I.registerLazySingleton<FailureRepository>(
    FailureRepository.new, //GetIt.I.get<FirebaseCrashlytics>()
  );
}
