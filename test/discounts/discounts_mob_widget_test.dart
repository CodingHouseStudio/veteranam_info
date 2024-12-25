import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/extension/extension_flutter_constants.dart';
import 'package:veteranam/shared/shared_dart.dart';

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
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;
    late AppInfoRepository mockBuildRepository;
    late MobileRatingRepository mockMobileRatingRepository;
    late UserRepository mockUserRepository;
    setUp(() {
      Config.testIsWeb = false;
      PlatformEnumFlutter.isWebDesktop = true;
      Config.isReleaseMode = true;
      Config.falvourValue = Config.production;
      ExtendedDateTime.id = KTestText.id;
      ExtendedDateTime.current = KTestText.dateTime;
      mockDiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      mockAuthenticationRepository = MockAuthenticationRepository();
      mockFirebaseAnalyticsService = MockFirebaseAnalyticsService();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
      mockBuildRepository = MockAppInfoRepository();
      mockMobileRatingRepository = MockMobileRatingRepository();
      mockUserRepository = MockUserRepository();

      when(mockMobileRatingRepository.showRatingDialog()).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(mockAuthenticationRepository.currectAuthenticationStatus).thenAnswer(
        (realInvocation) => AuthenticationStatus.anonymous,
      );
      // when(mockUserRepository.isAnonymously).thenAnswer(
      //   (realInvocation) => true,
      // );

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
        (invocation) async => const Right(-1),
      );
      when(
        mockDiscountRepository.getDiscountItems(
          showOnlyBusinessDiscounts: false,
          // reportIdItems: KTestText.reportItems.getIdCard,
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

      when(
        mockFirebaseRemoteConfigProvider
            .getString(AppVersionCubit.mobAppVersionKey),
      ).thenAnswer(
        (_) => AppInfoRepository.defaultValue.buildNumber,
      );

      when(mockBuildRepository.getBuildInfo()).thenAnswer(
        (invocation) async => AppInfoRepository.defaultValue,
      );
    });
    testWidgets('${KGroupText.initial} ', (tester) async {
      await discountsPumpAppHelper(
        tester: tester,
        mockDiscountRepository: mockDiscountRepository,
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        mockReportRepository: mockReportRepository,
        mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        mockAuthenticationRepository: mockAuthenticationRepository,
        mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
        mockBuildRepository: mockBuildRepository,
        mockUserRepository: mockUserRepository,
        mockMobileRatingRepository: mockMobileRatingRepository,
      );

      await discountsInitialHelper(tester);
    });

    testWidgets('${KGroupText.offlineNetwork} ', (tester) async {
      await networkMobHelper(
        tester: tester,
        pumpApp: () async => discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockReportRepository: mockReportRepository,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
          mockBuildRepository: mockBuildRepository,
          mockMobileRatingRepository: mockMobileRatingRepository,
          mockUserRepository: mockUserRepository,
        ),
      );
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockGoRouter: mockGoRouter,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          mockReportRepository: mockReportRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
          mockUserRepository: mockUserRepository,
          mockBuildRepository: mockBuildRepository,
          mockMobileRatingRepository: mockMobileRatingRepository,
        );

        await discountsInitialHelper(tester);
      });
      // group('Open Update dialog', () {
      //   setUp(() {
      //     PlatformEnumFlutter.isWebDesktop = false;
      //     when(
      //       mockFirebaseRemoteConfigProvider
      //           .getString(AppVersionCubit.mobAppVersionKey),
      //     ).thenAnswer(
      //       (_) => KTestText.build,
      //     );
      //   });
      //   testWidgets('${KGroupText.initial} ', (tester) async {
      //     await discountsPumpAppHelper(
      //       tester: tester,
      //       mockDiscountRepository: mockDiscountRepository,
      //       mockGoRouter: mockGoRouter,
      //       mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      //       mockFirebaseRemoteConfigProvider:
      // mockFirebaseRemoteConfigProvider,
      //       mockReportRepository: mockReportRepository,
      //       mockAuthenticationRepository: mockAuthenticationRepository,
      //       mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
      //       mockUserRepository: mockUserRepository,
      //       mockMobileRatingRepository: mockMobileRatingRepository,
      //       mockBuildRepository: mockBuildRepository,
      //     );

      //     await mobUpdateDialogButtonsHelper(
      //       tester: tester,
      //       mockGoRouter: mockGoRouter,
      //     );
      //   });
      // });
      group('${KGroupText.goTo} ', () {
        testWidgets('bottom navigations ', (tester) async {
          await discountsPumpAppHelper(
            tester: tester,
            mockDiscountRepository: mockDiscountRepository,
            mockGoRouter: mockGoRouter,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
            mockReportRepository: mockReportRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
            mockUserRepository: mockUserRepository,
            mockMobileRatingRepository: mockMobileRatingRepository,
            mockBuildRepository: mockBuildRepository,
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
