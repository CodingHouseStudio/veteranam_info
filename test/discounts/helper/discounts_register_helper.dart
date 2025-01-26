import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IDiscountRepository mockDiscountRepository;
late IAppAuthenticationRepository mockAppAuthenticationRepository;
late IReportRepository mockReportRepository;
late AuthenticationRepository mockAuthenticationRepository;
late FirebaseAnalyticsService mockFirebaseAnalyticsService;
late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;
late AppInfoRepository mockBuildRepository;
late MobileRatingRepository mockMobileRatingRepository;
void discountsWidgetTestRegister() {
  // KTest.animatioRepeat=1;
  ExtendedDateTime.id = KTestVariables.id;
  ExtendedDateTime.current = KTestVariables.dateTime;
  mockDiscountRepository = MockIDiscountRepository();
  mockAppAuthenticationRepository = MockAppAuthenticationRepository();
  mockAuthenticationRepository = MockAuthenticationRepository();
  mockFirebaseAnalyticsService = MockFirebaseAnalyticsService();
  mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
  mockReportRepository = MockIReportRepository();
  mockBuildRepository = MockAppInfoRepository();
  mockMobileRatingRepository = MockMobileRatingRepository();

  when(mockMobileRatingRepository.showRatingDialog()).thenAnswer(
    (realInvocation) async => const Right(true),
  );
  when(mockFirebaseRemoteConfigProvider.waitActivated()).thenAnswer(
    (invocation) async => true,
  );
  when(
    mockFirebaseRemoteConfigProvider
        .getBool(DiscountConfigCubit.enableVerticalDiscountKey),
  ).thenAnswer(
    (invocation) => true,
  );

  when(mockAuthenticationRepository.currectAuthenticationStatus).thenAnswer(
    (realInvocation) => AuthenticationStatus.anonymous,
  );
  // when(mockUserRepository.isAnonymously).thenAnswer(
  //   (realInvocation) => true,
  // );

  when(mockAppAuthenticationRepository.currentUser).thenAnswer(
    (invocation) => KTestVariables.user,
  );

  when(
    mockReportRepository.getCardReportById(
      cardEnum: CardEnum.discount,
      userId: KTestVariables.user.id,
    ),
  ).thenAnswer(
    (invocation) async => Right(KTestVariables.reportItems),
  );

  when(mockDiscountRepository.userCanSendLink(KTestVariables.user.id))
      .thenAnswer(
    (invocation) async => const Right(true),
  );
  when(mockDiscountRepository.userCanSendUserEmail(KTestVariables.user.id))
      .thenAnswer(
    (invocation) async => const Right(-1),
  );
  when(mockBuildRepository.getBuildInfo()).thenAnswer(
    (invocation) async => AppInfoRepository.defaultValue,
  );
  when(mockDiscountRepository.sendLink(KTestVariables.linkModel)).thenAnswer(
    (invocation) async => const Right(true),
  );
  when(mockDiscountRepository.sendEmail(KTestVariables.emailModel)).thenAnswer(
    (invocation) async => const Right(true),
  );

  _regsiterRepository();
}

void _regsiterRepository() {
  registerSingleton(mockDiscountRepository);
  registerSingleton(mockAppAuthenticationRepository);
  registerSingleton(mockReportRepository);
  registerSingleton(mockAuthenticationRepository);
  registerSingleton(mockFirebaseAnalyticsService);
  registerSingleton(mockFirebaseRemoteConfigProvider);
  registerSingleton(mockBuildRepository);
  registerSingleton(mockMobileRatingRepository);

  // registerFactoryParam<ReportBloc, String, CardEnum>(
  //   (cardId, card) => ReportBloc(
  //     reportRepository: mockReportRepository,
  //     appAuthenticationRepository: mockAppAuthenticationRepository,
  //     cardId: KTestVariables.id,
  //     card: CardEnum.funds,
  //   ),
  // );
  // registerFactory<DiscountsWatcherBloc>(
  //   () => DiscountsWatcherBloc(
  //     discountRepository: mockDiscountRepository,
  //     // reportRepository: mockReportRepository,
  //     // appAuthenticationRepository: mockAppAuthenticationRepository,
  //     firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
  //   ),
  // );
  // registerFactory<AuthenticationBloc>(
  //   () => AuthenticationBloc(
  //     authenticationRepository: mockAuthenticationRepository,
  //   ),
  // );
  // registerFactory<DiscountLinkFormBloc>(
  //   () => DiscountLinkFormBloc(
  //     discountRepository: mockDiscountRepository,
  //     appAuthenticationRepository: mockAppAuthenticationRepository,
  //   ),
  // );
  // registerFactory<DiscountLinkCubit>(
  //   () => DiscountLinkCubit(
  //     discountRepository: mockDiscountRepository,
  //     appAuthenticationRepository: mockAppAuthenticationRepository,
  //   ),
  // );
  // registerFactory<UserEmailFormBloc>(
  //   () => UserEmailFormBloc(
  //     discountRepository: mockDiscountRepository,
  //     appAuthenticationRepository: mockAppAuthenticationRepository,
  //     firebaseAnalyticsService: mockFirebaseAnalyticsService,
  //   ),
  // );
  // registerFactory<MobileRatingCubit>(
  //   () => MobileRatingCubit(
  //     mobileRatingRepository: mockMobileRatingRepository,
  //   ),
  // );
  // registerFactory<DiscountConfigCubit>(
  //   () => DiscountConfigCubit(
  //     firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
  //   ),
  // );
  // registerFactory<AppVersionCubit>(
  //   () => AppVersionCubit(
  //     buildRepository: mockBuildRepository,
  //     firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
  //   ),
  // );
  // registerFactory<ViewModeCubit>(ViewModeCubit.new);
}
