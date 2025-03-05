// ignore_for_file: cascade_invocations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:veteranam/components/company/bloc/company_form_bloc.dart';
import 'package:veteranam/components/discount/bloc/discount_watcher_bloc.dart';
import 'package:veteranam/components/discount_card/bloc/discount_card_watcher_cubit.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts_add/bloc/discounts_add_bloc.dart';
import 'package:veteranam/components/employee_respond/bloc/employee_respond_bloc.dart';
import 'package:veteranam/components/feedback/bloc/feedback_bloc.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/components/information/bloc/information_watcher_bloc.dart';
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart';
import 'package:veteranam/components/login/bloc/login_bloc.dart';
import 'package:veteranam/components/markdown_file_dialog/bloc/markdown_file_cubit.dart';
import 'package:veteranam/components/mob_faq/bloc/mob_faq_watcher_bloc.dart';
import 'package:veteranam/components/my_discounts/bloc/my_discounts_watcher_bloc.dart';
import 'package:veteranam/components/my_story/bloc/my_story_watcher_bloc.dart';
import 'package:veteranam/components/news_card/bloc/news_card_watcher_bloc.dart';
import 'package:veteranam/components/password_reset/bloc/check_code/check_verification_code_cubit.dart';
import 'package:veteranam/components/password_reset/bloc/form/password_reset_bloc.dart';
import 'package:veteranam/components/profile/bloc/profile_bloc.dart';
import 'package:veteranam/components/pw_reset_email/bloc/pw_reset_email_bloc.dart';
import 'package:veteranam/components/questions_form/bloc/user_role_bloc.dart';
import 'package:veteranam/components/sign_up/bloc/sign_up_bloc.dart';
import 'package:veteranam/components/story/bloc/story_watcher_bloc.dart';
import 'package:veteranam/components/story_add/bloc/story_add_bloc.dart';
import 'package:veteranam/components/work_employee/bloc/work_employee_watcher_bloc.dart';
import 'package:veteranam/shared/repositories/app_layout_repository.dart';
import 'package:veteranam/shared/shared_dart.dart';

import 'test_dependency.dart';

final getItTest = GetIt.I;
void resetTestVariables() {
  Config.testIsWeb = true;
  Config.falvourValue = Config.development;
  Config.roleValue = Config.user;
  KTest.isTest = true;
  Config.isReleaseMode = true;
  MockGoRouter.canPopValue = true;
  UriExtension.testUrl = null;
  KTest.discountSortingTestValue = false;
  DiscountsWatcherBloc.testDiscountFilterRepository = null;
  KTest.testLoading = false;
  ExtendedDateTime.current = KTestVariables.dateTime;
}

/// COMMENT: Method register Services, Repositories and Blocs in tests
void configureDependenciesTest() {
  AppLayoutRepository.widgetsBinding = null;
  final FirebaseFirestore mockFirebaseFirestore = MockFirebaseFirestore();
  // register logic if user id empty user setting is also empty
  initializeDateFormatting(Language.english.value.languageCode);
  initializeDateFormatting(Language.ukraine.value.languageCode);
  userSetting(mockFirebaseFirestore);
  discountInit(mockFirebaseFirestore);
  mobBuild();
  appLayoutCubitInit();
  firebaseAnalyticsCacheInit();

  // Service
  getItTest.registerSingleton<FirebaseFirestore>(
    mockFirebaseFirestore,
  );
  getItTest.registerSingleton<firebase_auth.FirebaseAuth>(MockFirebaseAuth());
  getItTest.registerSingleton<FlutterSecureStorage>(MockFlutterSecureStorage());
  getItTest.registerSingleton<GoogleSignIn>(GoogleSignIn());
  getItTest.registerSingleton<firebase_auth.GoogleAuthProvider>(
    MockGoogleAuthProvider(),
  );
  getItTest.registerSingleton<firebase_auth.FacebookAuthProvider>(
    MockFacebookAuthProvider(),
  );
  getItTest.registerSingleton<firebase_auth.AppleAuthProvider>(
    MockAppleAuthProvider(),
  );
  getItTest.registerSingleton<FacebookAuth>(MockFacebookAuth());
  getItTest.registerSingleton<StorageService>(MockStorageService());
  getItTest.registerSingleton<DeviceInfoPlugin>(DeviceInfoPlugin());
  getItTest.registerSingleton<FirebaseMessaging>(MockFirebaseMessaging());
  getItTest.registerSingleton<Connectivity>(Connectivity());
  getItTest.registerSingleton<FirestoreService>(
    FirestoreService(
      firebaseFirestore: getItTest.get<FirebaseFirestore>(),
      cache: CacheClient(),
    ),
  );
  getItTest.registerSingleton<IStorage>(
    SecureStorageRepository(
      secureStorage: getItTest.get<FlutterSecureStorage>(),
    ),
  );

  // Repository
  getItTest.registerSingleton<IUrlRepository>(UrlRepository());
  getItTest.registerSingleton<SharedPrefencesProvider>(
    MockSharedPrefencesProvider(),
  );
  getItTest.registerSingleton<ICompanyCacheRepository>(
    CompanyCacheRepository(
      sharedPrefencesRepository: getItTest.get<SharedPrefencesProvider>(),
    ),
  );
  getItTest.registerSingleton<ILanguageCacheRepository>(
    LanguageCacheRepository(
      sharedPrefencesRepository: getItTest.get<SharedPrefencesProvider>(),
    ),
  );
  getItTest.registerSingleton<IDeviceRepository>(
    DeviceRepository(
      firebaseMessaging: getItTest.get<FirebaseMessaging>(),
      deviceInfoPlugin: getItTest.get<DeviceInfoPlugin>(),
      buildRepository: getItTest.get<AppInfoRepository>(),
    ),
  );
  getItTest.registerSingleton<IAppAuthenticationRepository>(
    AppAuthenticationRepository(
      secureStorageRepository: getItTest.get<IStorage>(),
      firebaseAuth: getItTest.get<firebase_auth.FirebaseAuth>(),
      googleSignIn: getItTest.get<GoogleSignIn>(),
      cache: CacheClient(),
      facebookSignIn: getItTest.get<FacebookAuth>(),
      deviceRepository: getItTest.get<IDeviceRepository>(),
      facebookAuthProvider: getItTest.get<firebase_auth.FacebookAuthProvider>(),
      firestoreService: getItTest.get<FirestoreService>(),
      googleAuthProvider: getItTest.get<firebase_auth.GoogleAuthProvider>(),
      storageService: getItTest.get<StorageService>(),
      appleAuthProvider: getItTest.get<firebase_auth.AppleAuthProvider>(),
    ),
  );
  getItTest.registerSingleton<AuthenticationRepository>(
    AuthenticationRepository(
      appAuthenticationRepository:
          getItTest.get<IAppAuthenticationRepository>(),
    ),
  );
  getItTest.registerSingleton<UserRepository>(
    UserRepository(
      appAuthenticationRepository:
          getItTest.get<IAppAuthenticationRepository>(),
      languageCacheRepository: getItTest.get<ILanguageCacheRepository>(),
    ),
  );

  getItTest.registerSingleton<FirebaseAnalyticsService>(
    FirebaseAnalyticsService(
      firebaseAnalytics: MockFirebaseAnalytics(),
      userRepository: getItTest.get<UserRepository>(),
      firebaseAnalyticsCacheController:
          getItTest.get<FirebaseAnalyticsCacheController>(),
    ),
  );

  getItTest.registerSingleton<IAppNetworkRepository>(
    AppNetworkRepository(
      connectivity: getItTest.get<Connectivity>(),
      cache: CacheClient(),
    ),
  );
  getItTest.registerSingleton<NetworkRepository>(
    NetworkRepository(
      appNetworkRepository: getItTest.get<IAppNetworkRepository>(),
    ),
  );

  //Bloc
  getItTest.registerFactory<DiscountsWatcherBloc>(
    () => DiscountsWatcherBloc(
      discountRepository: getItTest.get<IDiscountRepository>(),
      firebaseRemoteConfigProvider:
          getItTest.get<FirebaseRemoteConfigProvider>(),
    ),
  );
  getItTest.registerFactory<FeedbackBloc>(
    () => FeedbackBloc(
      feedbackRepository: getItTest.get<IFeedbackRepository>(),
      appAuthenticationRepository:
          getItTest.get<IAppAuthenticationRepository>(),
    ),
  );
  getItTest.registerFactory<StoryWatcherBloc>(
    () => StoryWatcherBloc(storyRepository: getItTest.get<IStoryRepository>()),
  );
  getItTest.registerFactory<NetworkCubit>(
    () => NetworkCubit(networkRepository: getItTest.get<NetworkRepository>()),
  );
  getItTest.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      userRepository: getItTest.get<UserRepository>(),
      dataPickerRepository: getItTest.get<IDataPickerRepository>(),
    ),
  );
  getItTest.registerFactory<StoryAddBloc>(
    () => StoryAddBloc(
      storyRepository: getItTest.get<IStoryRepository>(),
      iAppAuthenticationRepository:
          getItTest.get<IAppAuthenticationRepository>(),
      dataPickerRepository: getItTest.get<IDataPickerRepository>(),
    ),
  );
  getItTest.registerFactory<DiscountLinkCubit>(
    () => DiscountLinkCubit(
      discountRepository: getItTest.get<IDiscountRepository>(),
      appAuthenticationRepository:
          getItTest.get<IAppAuthenticationRepository>(),
    ),
  );
  getItTest.registerFactory<PwResetEmailBloc>(
    () => PwResetEmailBloc(
      appAuthenticationRepository:
          getItTest.get<IAppAuthenticationRepository>(),
    ),
  );
  getItTest.registerFactory<MarkdownFileCubit>(
    () => MarkdownFileCubit(
      appAuthenticationRepository:
          getItTest.get<IAppAuthenticationRepository>(),
    ),
  );
  getItTest.registerFactory<PasswordResetBloc>(
    () => PasswordResetBloc(
      appAuthenticationRepository:
          getItTest.get<IAppAuthenticationRepository>(),
    ),
  );
  getItTest.registerFactory<UserRoleBloc>(
    () => UserRoleBloc(userRepository: getItTest.get<UserRepository>()),
  );
  getItTest.registerFactory<DiscountConfigCubit>(
    () => DiscountConfigCubit(
      firebaseRemoteConfigProvider:
          getItTest.get<FirebaseRemoteConfigProvider>(),
    ),
  );
  getItTest.registerFactory<MobFeedbackBloc>(
    () => MobFeedbackBloc(
      feedbackRepository: getItTest.get<IFeedbackRepository>(),
      appAuthenticationRepository:
          getItTest.get<IAppAuthenticationRepository>(),
    ),
  );
  getItTest.registerFactory<MobOfflineModeCubit>(
    () => MobOfflineModeCubit(
      firestoreService: getItTest.get<FirestoreService>(),
    ),
  );
  getItTest.registerFactory<HomeWatcherBloc>(
    () => HomeWatcherBloc(faqRepository: getItTest.get<IFaqRepository>()),
  );
  getItTest.registerFactory<WorkEmployeeWatcherBloc>(
    () => WorkEmployeeWatcherBloc(
      workRepository: getItTest.get<IWorkRepository>(),
    ),
  );
  getItTest.registerFactoryParam<CheckVerificationCodeCubit, String?, void>(
    (
      code,
      voidValue,
    ) =>
        CheckVerificationCodeCubit(
      appAuthenticationRepository:
          getItTest.get<IAppAuthenticationRepository>(),
      code: code,
    ),
  );
  getItTest.registerFactory<CompanyWatcherBloc>(
    () => CompanyWatcherBloc(
      companyRepository: getItTest.get<ICompanyRepository>(),
    ),
  );
  getItTest.registerFactoryParam<DiscountCardWatcherCubit, String?, void>(
    (
      id,
      voidValue,
    ) =>
        DiscountCardWatcherCubit(
      discountRepository: getItTest.get<IDiscountRepository>(),
      id: id,
    ),
  );
  getItTest.registerFactory<InformationWatcherBloc>(
    () => InformationWatcherBloc(
      informationRepository: getItTest.get<IInformationRepository>(),
    ),
  );
  getItTest.registerFactory<NewsCardWatcherBloc>(
    () => NewsCardWatcherBloc(
      informationRepository: getItTest.get<IInformationRepository>(),
    ),
  );
  getItTest.registerFactory<MyDiscountsWatcherBloc>(
    () => MyDiscountsWatcherBloc(
      discountRepository: getItTest.get<IDiscountRepository>(),
      companyRepository: getItTest.get<ICompanyRepository>(),
    ),
  );
  getItTest.registerFactory<UrlCubit>(
    () => UrlCubit(urlRepository: getItTest.get<IUrlRepository>()),
  );
  getItTest.registerFactory<EmployeeRespondBloc>(
    () => EmployeeRespondBloc(
      employeeRespondRepository: getItTest.get<IWorkRepository>(),
      dataPickerRepository: getItTest.get<IDataPickerRepository>(),
    ),
  );
  getItTest.registerFactoryParam<ReportBloc, String, CardEnum>(
    (
      cardId,
      card,
    ) =>
        ReportBloc(
      reportRepository: getItTest.get<IReportRepository>(),
      appAuthenticationRepository:
          getItTest.get<IAppAuthenticationRepository>(),
      cardId: cardId,
      card: card,
    ),
  );
  getItTest.registerFactory<MobFaqWatcherBloc>(
    () => MobFaqWatcherBloc(faqRepository: getItTest.get<IFaqRepository>()),
  );
  getItTest.registerFactoryParam<DiscountWatcherBloc, DiscountModel?, String?>(
    (
      discount,
      discountId,
    ) =>
        DiscountWatcherBloc(
      discountRepository: getItTest.get<IDiscountRepository>(),
      firebaseRemoteConfigProvider:
          getItTest.get<FirebaseRemoteConfigProvider>(),
      discount: discount,
      discountId: discountId,
    ),
  );
  getItTest.registerFactory<ViewModeCubit>(
    ViewModeCubit.new,
  );
  getItTest.registerFactory<MobileRatingCubit>(
    () => MobileRatingCubit(
      mobileRatingRepository: getItTest.get<MobileRatingRepository>(),
    ),
  );
  getItTest.registerFactory<UserWatcherBloc>(
    () => UserWatcherBloc(userRepository: getItTest.get<UserRepository>()),
  );
  getItTest.registerFactory<MyStoryWatcherBloc>(
    () => MyStoryWatcherBloc(
      storyRepository: getItTest.get<IStoryRepository>(),
      appAuthenticationRepository:
          getItTest.get<IAppAuthenticationRepository>(),
    ),
  );
  getItTest.registerFactory<UserEmailFormBloc>(
    () => UserEmailFormBloc(
      discountRepository: getItTest.get<IDiscountRepository>(),
      appAuthenticationRepository:
          getItTest.get<IAppAuthenticationRepository>(),
      firebaseAnalyticsService: getItTest.get<FirebaseAnalyticsService>(),
    ),
  );
  getItTest.registerFactory<InvestorsWatcherBloc>(
    () => InvestorsWatcherBloc(
      investorsRepository: getItTest.get<IInvestorsRepository>(),
    ),
  );
  getItTest.registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(
      authenticationRepository: getItTest.get<AuthenticationRepository>(),
    ),
  );
  getItTest.registerFactory<AuthenticationServicesCubit>(
    () => AuthenticationServicesCubit(
      authenticationRepository: getItTest.get<AuthenticationRepository>(),
    ),
  );
  getItTest.registerFactory<SignUpBloc>(
    () => SignUpBloc(
      authenticationRepository: getItTest.get<AuthenticationRepository>(),
    ),
  );
  getItTest.registerFactory<LoginBloc>(
    () => LoginBloc(
      authenticationRepository: getItTest.get<AuthenticationRepository>(),
    ),
  );
  getItTest.registerFactory<DiscountLinkFormBloc>(
    () => DiscountLinkFormBloc(
      discountRepository: getItTest.get<IDiscountRepository>(),
      appAuthenticationRepository:
          getItTest.get<IAppAuthenticationRepository>(),
    ),
  );
  getItTest.registerFactoryParam<DiscountsAddBloc, DiscountModel?, String?>(
    (
      discount,
      discountId,
    ) =>
        DiscountsAddBloc(
      discountRepository: getItTest.get<IDiscountRepository>(),
      companyRepository: getItTest.get<ICompanyRepository>(),
      citiesRepository: getItTest.get<ICitiesRepository>(),
      discount: discount,
      discountId: discountId,
    ),
  );
  getItTest.registerFactory<CompanyFormBloc>(
    () => CompanyFormBloc(
      companyRepository: getItTest.get<ICompanyRepository>(),
      dataPickerRepository: getItTest.get<IDataPickerRepository>(),
      discountRepository: getItTest.get<IDiscountRepository>(),
    ),
  );
  getItTest.registerFactory<AppVersionCubit>(
    () => AppVersionCubit(
      buildRepository: getItTest.get<AppInfoRepository>(),
      firebaseRemoteConfigProvider:
          getItTest.get<FirebaseRemoteConfigProvider>(),
    ),
  );
  getItTest.registerFactory<CookiesDialogCubit>(
    () => CookiesDialogCubit(
      firebaseAnalyticsService: getItTest.get<FirebaseAnalyticsService>(),
    ),
  );
}

void configureFailureDependenciesTest() {
  final FirebaseFirestore mockFirebaseFirestore = MockFirebaseFirestore();
  // register logic if user id empty user setting is also empty
  userSetting(mockFirebaseFirestore);
  initializeDateFormatting(Language.english.value.languageCode);
  initializeDateFormatting(Language.ukraine.value.languageCode);

  // KTest.scroll = null;
  // Services
  getItTest.registerSingleton<FirebaseFirestore>(mockFirebaseFirestore);
  getItTest.registerSingleton<Dio>(Dio());
  // getIt.registerSingleton<FirebaseCrashlytics>(MockFirebaseCrashlytics());
  getItTest.registerSingleton<ArtifactDownloadHelper>(
    ArtifactDownloadHelper(
      dio: getItTest.get<Dio>(),
    ),
  );

  // Repositories
  getItTest.registerLazySingleton<FailureRepository>(
    FailureRepository.new, //getIt.get<FirebaseCrashlytics>()
  );
}
