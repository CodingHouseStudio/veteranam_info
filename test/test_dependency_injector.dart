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
  appLayoutCubitInit();
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

  // Service
  GetIt.I.registerSingleton<FirebaseFirestore>(
    mockFirebaseFirestore,
  );
  GetIt.I.registerSingleton<firebase_auth.FirebaseAuth>(MockFirebaseAuth());
  GetIt.I.registerSingleton<FlutterSecureStorage>(MockFlutterSecureStorage());
  GetIt.I.registerSingleton<GoogleSignIn>(GoogleSignIn());
  GetIt.I.registerSingleton<firebase_auth.GoogleAuthProvider>(
    MockGoogleAuthProvider(),
  );
  GetIt.I.registerSingleton<firebase_auth.FacebookAuthProvider>(
    MockFacebookAuthProvider(),
  );
  GetIt.I.registerSingleton<FacebookAuth>(MockFacebookAuth());
  GetIt.I.registerSingleton<StorageService>(MockStorageService());
  GetIt.I.registerSingleton<DeviceInfoPlugin>(DeviceInfoPlugin());
  GetIt.I.registerSingleton<FirebaseMessaging>(MockFirebaseMessaging());
  GetIt.I.registerSingleton<Connectivity>(Connectivity());
  GetIt.I.registerSingleton<FirestoreService>(
    FirestoreService(
      firebaseFirestore: GetIt.I.get<FirebaseFirestore>(),
      cache: CacheClient(),
    ),
  );
  GetIt.I.registerSingleton<IStorage>(
    SecureStorageRepository(
      secureStorage: GetIt.I.get<FlutterSecureStorage>(),
    ),
  );

  // Repository
  GetIt.I.registerSingleton<IUrlRepository>(UrlRepository());
  GetIt.I.registerSingleton<IDeviceRepository>(
    DeviceRepository(
      firebaseMessaging: GetIt.I.get<FirebaseMessaging>(),
      deviceInfoPlugin: GetIt.I.get<DeviceInfoPlugin>(),
      buildRepository: GetIt.I.get<AppInfoRepository>(),
    ),
  );
  GetIt.I.registerSingleton<IAppAuthenticationRepository>(
    AppAuthenticationRepository(
      secureStorageRepository: GetIt.I.get<IStorage>(),
      firebaseAuth: GetIt.I.get<firebase_auth.FirebaseAuth>(),
      googleSignIn: GetIt.I.get<GoogleSignIn>(),
      cache: CacheClient(),
      facebookSignIn: GetIt.I.get<FacebookAuth>(),
      deviceRepository: GetIt.I.get<IDeviceRepository>(),
      facebookAuthProvider: GetIt.I.get<firebase_auth.FacebookAuthProvider>(),
      firestoreService: GetIt.I.get<FirestoreService>(),
      googleAuthProvider: GetIt.I.get<firebase_auth.GoogleAuthProvider>(),
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
  GetIt.I.registerSingleton<IAppNetworkRepository>(
    AppNetworkRepository(
      connectivity: GetIt.I.get<Connectivity>(),
      cache: CacheClient(),
    ),
  );
  GetIt.I.registerSingleton<NetworkRepository>(
    NetworkRepository(
      appNetworkRepository: GetIt.I.get<IAppNetworkRepository>(),
    ),
  );

  //Bloc
  GetIt.I.registerFactory<DiscountsWatcherBloc>(
    () => DiscountsWatcherBloc(
      discountRepository: GetIt.I.get<IDiscountRepository>(),
      firebaseRemoteConfigProvider: GetIt.I.get<FirebaseRemoteConfigProvider>(),
    ),
  );
  GetIt.I.registerFactory<FeedbackBloc>(
    () => FeedbackBloc(
      feedbackRepository: GetIt.I.get<IFeedbackRepository>(),
      appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>(),
    ),
  );
  GetIt.I.registerFactory<StoryWatcherBloc>(
    () => StoryWatcherBloc(storyRepository: GetIt.I.get<IStoryRepository>()),
  );
  GetIt.I.registerFactory<NetworkCubit>(
    () => NetworkCubit(networkRepository: GetIt.I.get<NetworkRepository>()),
  );
  GetIt.I.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      userRepository: GetIt.I.get<UserRepository>(),
      dataPickerRepository: GetIt.I.get<IDataPickerRepository>(),
    ),
  );
  GetIt.I.registerFactory<StoryAddBloc>(
    () => StoryAddBloc(
      storyRepository: GetIt.I.get<IStoryRepository>(),
      iAppAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>(),
      dataPickerRepository: GetIt.I.get<IDataPickerRepository>(),
    ),
  );
  GetIt.I.registerFactory<DiscountLinkCubit>(
    () => DiscountLinkCubit(
      discountRepository: GetIt.I.get<IDiscountRepository>(),
      appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>(),
    ),
  );
  GetIt.I.registerFactory<PwResetEmailBloc>(
    () => PwResetEmailBloc(
      appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>(),
    ),
  );
  GetIt.I.registerFactory<MarkdownFileCubit>(
    () => MarkdownFileCubit(
      appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>(),
    ),
  );
  GetIt.I.registerFactory<PasswordResetBloc>(
    () => PasswordResetBloc(
      appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>(),
    ),
  );
  GetIt.I.registerFactory<UserRoleBloc>(
    () => UserRoleBloc(userRepository: GetIt.I.get<UserRepository>()),
  );
  GetIt.I.registerFactory<DiscountConfigCubit>(
    () => DiscountConfigCubit(
      firebaseRemoteConfigProvider: GetIt.I.get<FirebaseRemoteConfigProvider>(),
    ),
  );
  GetIt.I.registerFactory<MobFeedbackBloc>(
    () => MobFeedbackBloc(
      feedbackRepository: GetIt.I.get<IFeedbackRepository>(),
      appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>(),
    ),
  );
  GetIt.I.registerFactory<MobOfflineModeCubit>(
    () =>
        MobOfflineModeCubit(firestoreService: GetIt.I.get<FirestoreService>()),
  );
  GetIt.I.registerFactory<HomeWatcherBloc>(
    () => HomeWatcherBloc(faqRepository: GetIt.I.get<IFaqRepository>()),
  );
  GetIt.I.registerFactory<WorkEmployeeWatcherBloc>(
    () =>
        WorkEmployeeWatcherBloc(workRepository: GetIt.I.get<IWorkRepository>()),
  );
  GetIt.I.registerFactoryParam<CheckVerificationCodeCubit, String?, void>(
    (
      code,
      voidValue,
    ) =>
        CheckVerificationCodeCubit(
      appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>(),
      code: code,
    ),
  );
  GetIt.I.registerFactory<CompanyWatcherBloc>(
    () => CompanyWatcherBloc(
      companyRepository: GetIt.I.get<ICompanyRepository>(),
    ),
  );
  GetIt.I.registerFactoryParam<DiscountCardWatcherCubit, String?, void>(
    (
      id,
      voidValue,
    ) =>
        DiscountCardWatcherCubit(
      discountRepository: GetIt.I.get<IDiscountRepository>(),
      id: id,
    ),
  );
  GetIt.I.registerFactory<InformationWatcherBloc>(
    () => InformationWatcherBloc(
      informationRepository: GetIt.I.get<IInformationRepository>(),
    ),
  );
  GetIt.I.registerFactory<NewsCardWatcherBloc>(
    () => NewsCardWatcherBloc(
      informationRepository: GetIt.I.get<IInformationRepository>(),
    ),
  );
  GetIt.I.registerFactory<MyDiscountsWatcherBloc>(
    () => MyDiscountsWatcherBloc(
      discountRepository: GetIt.I.get<IDiscountRepository>(),
      companyRepository: GetIt.I.get<ICompanyRepository>(),
    ),
  );
  GetIt.I.registerFactory<UrlCubit>(
    () => UrlCubit(urlRepository: GetIt.I.get<IUrlRepository>()),
  );
  GetIt.I.registerFactory<EmployeeRespondBloc>(
    () => EmployeeRespondBloc(
      employeeRespondRepository: GetIt.I.get<IWorkRepository>(),
      dataPickerRepository: GetIt.I.get<IDataPickerRepository>(),
    ),
  );
  GetIt.I.registerFactoryParam<ReportBloc, String, CardEnum>(
    (
      cardId,
      card,
    ) =>
        ReportBloc(
      reportRepository: GetIt.I.get<IReportRepository>(),
      appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>(),
      cardId: cardId,
      card: card,
    ),
  );
  GetIt.I.registerFactory<MobFaqWatcherBloc>(
    () => MobFaqWatcherBloc(faqRepository: GetIt.I.get<IFaqRepository>()),
  );
  GetIt.I.registerFactoryParam<DiscountWatcherBloc, DiscountModel?, String?>(
    (
      discount,
      discountId,
    ) =>
        DiscountWatcherBloc(
      discountRepository: GetIt.I.get<IDiscountRepository>(),
      firebaseRemoteConfigProvider: GetIt.I.get<FirebaseRemoteConfigProvider>(),
      discount: discount,
      discountId: discountId,
    ),
  );
  GetIt.I.registerFactory<ViewModeCubit>(
    ViewModeCubit.new,
  );
  GetIt.I.registerFactory<MobileRatingCubit>(
    () => MobileRatingCubit(
      mobileRatingRepository: GetIt.I.get<MobileRatingRepository>(),
    ),
  );
  GetIt.I.registerFactory<UserWatcherBloc>(
    () => UserWatcherBloc(userRepository: GetIt.I.get<UserRepository>()),
  );
  GetIt.I.registerFactory<MyStoryWatcherBloc>(
    () => MyStoryWatcherBloc(
      storyRepository: GetIt.I.get<IStoryRepository>(),
      appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>(),
    ),
  );
  GetIt.I.registerFactory<UserEmailFormBloc>(
    () => UserEmailFormBloc(
      discountRepository: GetIt.I.get<IDiscountRepository>(),
      appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>(),
      firebaseAnalyticsService: GetIt.I.get<FirebaseAnalyticsService>(),
    ),
  );
  GetIt.I.registerFactory<InvestorsWatcherBloc>(
    () => InvestorsWatcherBloc(
      investorsRepository: GetIt.I.get<IInvestorsRepository>(),
    ),
  );
  GetIt.I.registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(
      authenticationRepository: GetIt.I.get<AuthenticationRepository>(),
    ),
  );
  GetIt.I.registerFactory<AuthenticationServicesCubit>(
    () => AuthenticationServicesCubit(
      authenticationRepository: GetIt.I.get<AuthenticationRepository>(),
    ),
  );
  GetIt.I.registerFactory<SignUpBloc>(
    () => SignUpBloc(
      authenticationRepository: GetIt.I.get<AuthenticationRepository>(),
    ),
  );
  GetIt.I.registerFactory<LoginBloc>(
    () => LoginBloc(
      authenticationRepository: GetIt.I.get<AuthenticationRepository>(),
    ),
  );
  GetIt.I.registerFactory<DiscountLinkFormBloc>(
    () => DiscountLinkFormBloc(
      discountRepository: GetIt.I.get<IDiscountRepository>(),
      appAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>(),
    ),
  );
  GetIt.I.registerFactoryParam<DiscountsAddBloc, DiscountModel?, String?>(
    (
      discount,
      discountId,
    ) =>
        DiscountsAddBloc(
      discountRepository: GetIt.I.get<IDiscountRepository>(),
      companyRepository: GetIt.I.get<ICompanyRepository>(),
      citiesRepository: GetIt.I.get<ICitiesRepository>(),
      discount: discount,
      discountId: discountId,
    ),
  );
  GetIt.I.registerFactory<CompanyFormBloc>(
    () => CompanyFormBloc(
      companyRepository: GetIt.I.get<ICompanyRepository>(),
      dataPickerRepository: GetIt.I.get<IDataPickerRepository>(),
      discountRepository: GetIt.I.get<IDiscountRepository>(),
    ),
  );
  GetIt.I.registerFactory<AppVersionCubit>(
    () => AppVersionCubit(
      buildRepository: GetIt.I.get<AppInfoRepository>(),
      firebaseRemoteConfigProvider: GetIt.I.get<FirebaseRemoteConfigProvider>(),
    ),
  );
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
  UriExtension.testUrl = null;
  KTest.discountSortingTestValue = false;
  DiscountsWatcherBloc.testDiscountFilterRepository = null;
  KTest.testLoading = false;

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
