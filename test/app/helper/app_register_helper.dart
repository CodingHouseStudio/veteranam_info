import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IFaqRepository mockFaqRepository;
late IDiscountRepository mockDiscountRepository;
late IInvestorsRepository mockInvestorsRepository;
late IAppAuthenticationRepository mockAppAuthenticationRepository;
// late IReportRepository mockReportRepository;
late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;
late FirebaseAnalyticsService mockFirebaseAnalyticsService;
late MobileRatingRepository mockMobileRatingRepository;
void appWidgetTestRegister() {
  mockDiscountRepository = MockIDiscountRepository();
  mockAppAuthenticationRepository = MockAppAuthenticationRepository();
  mockFaqRepository = MockIFaqRepository();
  mockInvestorsRepository = MockIInvestorsRepository();
  mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
  mockFirebaseAnalyticsService = MockFirebaseAnalyticsService();
  mockMobileRatingRepository = MockMobileRatingRepository();

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
  when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
    (realInvocation) => KTestVariables.userSetting,
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

  _registerRepository();
}

void _registerRepository() {
  registerSingleton(mockFaqRepository);
  registerSingleton(mockDiscountRepository);
  registerSingleton(mockInvestorsRepository);
  registerSingleton(mockAppAuthenticationRepository);
  registerSingleton(mockFirebaseRemoteConfigProvider);
  registerSingleton(mockFirebaseAnalyticsService);
  registerSingleton(mockMobileRatingRepository);
}
