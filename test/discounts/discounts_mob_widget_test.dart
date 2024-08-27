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
  group('${KScreenBlocName.discount} ${KScreenBlocName.mobile}', () {
    late IDiscountRepository mockDiscountRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late IReportRepository mockReportRepository;
    late AuthenticationRepository mockAuthenticationRepository;
    late FirebaseAnalyticsService mockFirebaseAnalyticsService;
    setUp(() {
      KTest.testIsWeb = false;
      KPlatformConstants.isWebDesktop = true;
      Config.value = Config.production;
      ExtendedDateTime.id = KTestText.id;
      ExtendedDateTime.current = KTestText.dateTime;
      mockDiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      mockAuthenticationRepository = MockAuthenticationRepository();
      mockFirebaseAnalyticsService = MockFirebaseAnalyticsService();

      when(mockAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => User.empty,
      );
      when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => UserSetting.empty,
      );
      when(mockAuthenticationRepository.isAnonymouslyOrEmty()).thenAnswer(
        (realInvocation) => true,
      );

      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (invocation) => KTestText.user,
      );

      mockReportRepository = MockIReportRepository();
      when(
        mockReportRepository.getCardReportById(
          cardEnum: CardEnum.discount,
          userId: KTestText.user.id,
        ),
      ).thenAnswer(
        (invocation) async => Right(KTestText.reportItems),
      );

      when(mockDiscountRepository.userCanSendLink(KTestText.user.id))
          .thenAnswer(
        (invocation) async => const Right(true),
      );
      when(mockDiscountRepository.userCanSendUserEmail(KTestText.user.id))
          .thenAnswer(
        (invocation) async => const Right(false),
      );
      when(
        mockDiscountRepository.getDiscountItems(
          reportIdItems: KTestText.reportItems.getIdCard,
        ),
      ).thenAnswer(
        (invocation) => Stream.value(KTestText.discountModelItemsModify),
      );
      when(mockDiscountRepository.sendLink(KTestText.linkModel)).thenAnswer(
        (invocation) async => const Right(true),
      );
      when(mockDiscountRepository.sendEmail(KTestText.emailModel)).thenAnswer(
        (invocation) async => const Right(true),
      );
    });
    testWidgets('${KGroupText.intial} ', (tester) async {
      await discountsPumpAppHelper(
        tester: tester,
        mockDiscountRepository: mockDiscountRepository,
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        mockReportRepository: mockReportRepository,
        mockAuthenticationRepository: mockAuthenticationRepository,
        mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
      );

      await discountsInitialHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockGoRouter: mockGoRouter,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockReportRepository: mockReportRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
        );

        await discountsInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('bottom navigations ', (tester) async {
          await discountsPumpAppHelper(
            tester: tester,
            mockDiscountRepository: mockDiscountRepository,
            mockGoRouter: mockGoRouter,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockReportRepository: mockReportRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
          );

          await mobNavigationButtonsHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
