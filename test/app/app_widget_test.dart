import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

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
    // late IReportRepository mockReportRepository;
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;
    late FirebaseAnalyticsService mockFirebaseAnalyticsService;
    setUp(() {
      mockAuthenticationRepository = MockAuthenticationRepository();
      mockDiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      mockFaqRepository = MockIFaqRepository();
      mockInvestorsReportisory = MockIInvestorsRepository();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
      mockFirebaseAnalyticsService = MockFirebaseAnalyticsService();

      when(mockAuthenticationRepository.userSetting).thenAnswer(
        (realInvocation) => Stream.value(KTestText.userSetting),
      );
      when(mockAuthenticationRepository.status).thenAnswer(
        (realInvocation) => Stream.value(AuthenticationStatus.anonymous),
      );
      when(mockAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => User.empty,
      );
      when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => KTestText.userSetting,
      );
      when(mockFaqRepository.getQuestions()).thenAnswer(
        (invocation) async => Right(KTestText.questionModelItems),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (invocation) => KTestText.user,
      );

      // mockReportRepository = MockIReportRepository();
      // when(
      //   mockReportRepository.getCardReportById(
      //     cardEnum: CardEnum.discount,
      //     userId: KTestText.user.id,
      //   ),
      // ).thenAnswer(
      //   (invocation) async => Right(KTestText.reportItems),
      // );

      when(mockDiscountRepository.userCanSendLink(KTestText.user.id))
          .thenAnswer(
        (invocation) async => const Right(true),
      );
      when(mockDiscountRepository.userCanSendUserEmail(KTestText.user.id))
          .thenAnswer(
        (invocation) async => const Right(-1),
      );
      when(
        mockDiscountRepository.getDiscountItems(
            // reportIdItems: KTestText.reportItems.getIdCard,
            ),
      ).thenAnswer(
        (invocation) => Stream.value(KTestText.discountModelItemsModify),
      );

      when(
        mockInvestorsReportisory.getFunds(
            // reportIdItems: KTestText.reportItems.getIdCard,
            ),
      ).thenAnswer(
        (invocation) async => Right(KTestText.fundItems),
      );
    });

    group('Mobile', () {
      setUp(() => Config.isWeb = false);
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
        );
      });
    });

    group('Web', () {
      setUp(() => Config.isWeb = true);
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
        );
      });
    });
  });
}
