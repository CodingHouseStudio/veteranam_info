import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.app} ', () {
    late AuthenticationRepository mockAuthenticationRepository;
    late IFaqRepository mockFaqRepository;
    late IDiscountRepository mockDiscountRepository;
    late IInvestorsRepository mockInvestorsReportisory;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late UserRepository mockUserRepository;
    // late IReportRepository mockReportRepository;
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;
    late FirebaseAnalyticsService mockFirebaseAnalyticsService;
    late MobileRatingRepository mockMobileRatingRepository;
    setUp(() {
      mockAuthenticationRepository = MockAuthenticationRepository();
      mockDiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      mockFaqRepository = MockIFaqRepository();
      mockInvestorsReportisory = MockIInvestorsRepository();
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
        mockInvestorsReportisory.getFunds(
            // reportIdItems: KTestVariables.reportItems.getIdCard,
            ),
      ).thenAnswer(
        (invocation) async => Right(KTestVariables.fundItems),
      );
    });

    group('Mobile', () {
      setUp(() => Config.testIsWeb = false);
      testWidgets('${KGroupText.initial} ', (tester) async {
        await appPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
          mockFaqRepository: mockFaqRepository,
          // mockReportRepository: mockReportRepository,
          mockInvestorsReportisory: mockInvestorsReportisory,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
          mockMobileRatingRepository: mockMobileRatingRepository,
          mockUserRepository: mockUserRepository,
        );
      });
    });

    group('Web', () {
      setUp(() => Config.testIsWeb = true);
      testWidgets('${KGroupText.initial} ', (tester) async {
        await appPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
          mockFaqRepository: mockFaqRepository,
          // mockReportRepository: mockReportRepository,
          mockInvestorsReportisory: mockInvestorsReportisory,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
          mockMobileRatingRepository: mockMobileRatingRepository,
          mockUserRepository: mockUserRepository,
        );
      });
    });
  });
}
