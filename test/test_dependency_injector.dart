import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import 'test_dependency.dart';

/// COMMENT: Method register Services, Repositories and Blocs in tests
void configureDependenciesTest() {
  // register logic if user id empty user setting is also empty
  userSetting();
  mobBuild();
  Config.isWeb = true;
  Config.falvourValue = Config.development;
  Config.roleValue = Config.user;
  KTest.isTest = true;
  KTest.testReleaseMode = true;
  // KTest.scroll = null;
  // Services
  GetIt.I.registerSingleton<FirebaseCrashlytics>(MockFirebaseCrashlytics());
  GetIt.I.registerSingleton<Dio>(Dio());
  GetIt.I.registerSingleton<FirebaseAuth>(MockFirebaseAuth());
  GetIt.I.registerSingleton<GoogleSignIn>(GoogleSignIn());
  GetIt.I.registerSingleton<FacebookAuth>(MockFacebookAuth());
  GetIt.I.registerSingleton<FakeClient>(FakeClient());
  GetIt.I.registerSingleton<FirebaseAnalytics>(MockFirebaseAnalytics());
  GetIt.I.registerSingleton<FirebaseRemoteConfig>(MockFirebaseRemoteConfig());
  GetIt.I.registerSingleton<FirebaseMessaging>(MockFirebaseMessaging());
  GetIt.I.registerSingleton<StorageService>(MockStorageService());
  GetIt.I.registerSingleton<Connectivity>(Connectivity());
  GetIt.I.registerSingleton<DeviceInfoPlugin>(DeviceInfoPlugin());
  GetIt.I.registerSingleton<FirestoreService>(
    FirestoreService(CacheClient()),
  );
  GetIt.I.registerSingleton<FirebaseRemoteConfigProvider>(
    FirebaseRemoteConfigProvider(
      GetIt.I.get<FirebaseRemoteConfig>(),
    ),
  );
  GetIt.I.registerSingleton<ArtifactDownloadHelper>(
    ArtifactDownloadHelper(
      GetIt.I.get<Dio>(),
    ),
  );

  // Repositories
  GetIt.I.registerLazySingleton<FailureRepository>(
    () => FailureRepository(GetIt.I.get<FirebaseCrashlytics>()),
  );
  GetIt.I.registerLazySingleton<IStorage>(SecureStorageRepository.new);
  GetIt.I.registerSingleton<AppInfoRepository>(AppInfoRepository());
  GetIt.I.registerSingleton<IFeedbackRepository>(FeedbackRepository());
  GetIt.I.registerSingleton<IDeviceRepository>(
    DeviceRepository(
      GetIt.I.get<FirebaseMessaging>(),
      GetIt.I.get<DeviceInfoPlugin>(),
      GetIt.I.get<AppInfoRepository>(),
    ),
  );
  GetIt.I.registerSingleton<IFaqRepository>(FaqRepository());
  GetIt.I.registerSingleton<IAppAuthenticationRepository>(
    AppAuthenticationRepository(
      GetIt.I.get<IStorage>(),
      GetIt.I.get<FirebaseAuth>(),
      GetIt.I.get<GoogleSignIn>(),
      CacheClient(),
      GetIt.I.get<FacebookAuth>(),
    ),
  );
  GetIt.I.registerSingleton<AuthenticationRepository>(
    AuthenticationRepository(
      GetIt.I.get<IAppAuthenticationRepository>(),
    ),
  );
  GetIt.I.registerSingleton<FirebaseAnalyticsService>(
    FirebaseAnalyticsService(
      GetIt.I.get<FirebaseAnalytics>(),
      GetIt.I.get<AuthenticationRepository>(),
    ),
  );
  GetIt.I.registerSingleton<IAppNetworkRepository>(
    AppNetworkRepository(
      GetIt.I.get<Connectivity>(),
      CacheClient(),
    ),
  );
  GetIt.I.registerSingleton<IDiscountRepository>(DiscountRepository());
  GetIt.I.registerSingleton<IReportRepository>(ReportRepository());
  GetIt.I.registerSingleton<IUrlRepository>(UrlRepository());
  GetIt.I.registerSingleton<NetworkRepository>(
    NetworkRepository(
      GetIt.I.get<IAppNetworkRepository>(),
    ),
  );
  // GetIt.I.registerSingleton<IInformationRepository>(InformationRepository());
  GetIt.I.registerSingleton<IInvestorsRepository>(InvestorsRepository());
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
  GetIt.I.registerSingleton<MobOfflineModeCubit>(
    MobOfflineModeCubit(
      firestoreService: GetIt.I.get<FirestoreService>(),
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
  GetIt.I.registerSingleton<DiscountWatcherBloc>(
    DiscountWatcherBloc(
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
  // GetIt.I.registerSingleton<MyDiscountsWatcherBloc>(
  //   MyDiscountsWatcherBloc(
  //     discountRepository: GetIt.I.get<IDiscountRepository>(),
  //     iAppAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>
  // (),
  //   ),
  // );
}

void configureFailureDependenciesTest() {
  // register logic if user id empty user setting is also empty
  userSetting();
  Config.isWeb = true;
  Config.falvourValue = Config.development;
  KTest.isTest = true;
  KTest.testReleaseMode = true;
  // KTest.scroll = null;
  // Services
  GetIt.I.registerSingleton<Dio>(Dio());
  GetIt.I.registerSingleton<FirebaseCrashlytics>(MockFirebaseCrashlytics());
  GetIt.I.registerSingleton<ArtifactDownloadHelper>(
    ArtifactDownloadHelper(
      GetIt.I.get<Dio>(),
    ),
  );

  // Repositories
  GetIt.I.registerLazySingleton<FailureRepository>(
    () => FailureRepository(GetIt.I.get<FirebaseCrashlytics>()),
  );
}
