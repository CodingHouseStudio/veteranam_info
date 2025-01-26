import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart';
import 'package:veteranam/components/mob_faq/bloc/mob_faq_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late AuthenticationRepository mockAuthenticationRepository;
late IFaqRepository mockFaqRepository;
late IDiscountRepository mockDiscountRepository;
late IInvestorsRepository mockInvestorsRepository;
late IAppAuthenticationRepository mockAppAuthenticationRepository;
late UserRepository mockUserRepository;
// late IReportRepository mockReportRepository;
late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;
late FirebaseAnalyticsService mockFirebaseAnalyticsService;
late MobileRatingRepository mockMobileRatingRepository;
void appWidgetTestRegister() {
  mockAuthenticationRepository = MockAuthenticationRepository();
  mockDiscountRepository = MockIDiscountRepository();
  mockAppAuthenticationRepository = MockAppAuthenticationRepository();
  mockFaqRepository = MockIFaqRepository();
  mockInvestorsRepository = MockIInvestorsRepository();
  mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
  mockFirebaseAnalyticsService = MockFirebaseAnalyticsService();
  mockMobileRatingRepository = MockMobileRatingRepository();
  mockUserRepository = MockUserRepository();

  // when(mockAuthenticationRepository.userSetting).thenAnswer(
  //   (realInvocation) => Stream.value(KTestVariables.userSetting),
  // );
  // when(mockAuthenticationRepository.user).thenAnswer(
  //   (realInvocation) => Stream.value(KTestVariables.userAnonymous),
  // );
  // when(mockAuthenticationRepository.currentUser).thenAnswer(
  //   (realInvocation) => User.empty,
  // );
  // when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
  //   (realInvocation) => KTestVariables.userSetting,
  // );
  when(mockFaqRepository.getQuestions()).thenAnswer(
    (invocation) async => Right(KTestVariables.questionModelItems),
  );
  when(mockAppAuthenticationRepository.currentUser).thenAnswer(
    (invocation) => KTestVariables.user,
  );
  when(mockMobileRatingRepository.showRatingDialog()).thenAnswer(
    (realInvocation) async => const Right(true),
  );

  // mockReportRepository = MockIReportRepository();
  // when(
  //   mockReportRepository.getCardReportById(
  //     cardEnum: CardEnum.discount,
  //     userId: KTestVariables.user.id,
  //   ),
  // ).thenAnswer(
  //   (invocation) async => Right(KTestVariables.reportItems),
  // );

  when(mockDiscountRepository.userCanSendLink(KTestVariables.user.id))
      .thenAnswer(
    (invocation) async => const Right(true),
  );
  when(mockDiscountRepository.userCanSendUserEmail(KTestVariables.user.id))
      .thenAnswer(
    (invocation) async => const Right(-1),
  );
  when(
    mockDiscountRepository.getDiscountItems(
      showOnlyBusinessDiscounts: false,
      // reportIdItems: KTestVariables.reportItems.getIdCard,
    ),
  ).thenAnswer(
    (invocation) => Stream.value(KTestVariables.discountModelItemsModify),
  );

  when(
    mockInvestorsRepository.getFunds(
        // reportIdItems: KTestVariables.reportItems.getIdCard,
        ),
  ).thenAnswer(
    (invocation) async => Right(KTestVariables.fundItems),
  );

  _registerBloc();
}

void _registerBloc() {
  // AuthenticationBloc
  registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(
      authenticationRepository: mockAuthenticationRepository,
    ),
  );

  // HomeWatcherBloc
  registerFactory<HomeWatcherBloc>(
    () => HomeWatcherBloc(
      faqRepository: mockFaqRepository,
    ),
  );

  // DiscountLinkCubit
  registerFactory<DiscountLinkCubit>(
    () => DiscountLinkCubit(
      discountRepository: mockDiscountRepository,
      appAuthenticationRepository: mockAppAuthenticationRepository,
    ),
  );

  // UserEmailFormBloc
  registerFactory<UserEmailFormBloc>(
    () => UserEmailFormBloc(
      discountRepository: mockDiscountRepository,
      appAuthenticationRepository: mockAppAuthenticationRepository,
      firebaseAnalyticsService: mockFirebaseAnalyticsService,
    ),
  );

  // DiscountsWatcherBloc
  registerFactory<DiscountsWatcherBloc>(
    () => DiscountsWatcherBloc(
      discountRepository: mockDiscountRepository,
      firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
    ),
  );

  // InvestorsWatcherBloc
  registerFactory<InvestorsWatcherBloc>(
    () => InvestorsWatcherBloc(
      investorsRepository: mockInvestorsRepository,
    ),
  );

  // MobFaqWatcherBloc
  registerFactory<MobFaqWatcherBloc>(
    () => MobFaqWatcherBloc(
      faqRepository: mockFaqRepository,
    ),
  );

  // DiscountConfigCubit
  registerFactory<DiscountConfigCubit>(
    () => DiscountConfigCubit(
      firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
    ),
  );

  // MobileRatingCubit
  registerFactory<MobileRatingCubit>(
    () => MobileRatingCubit(
      mobileRatingRepository: mockMobileRatingRepository,
    ),
  );
}
