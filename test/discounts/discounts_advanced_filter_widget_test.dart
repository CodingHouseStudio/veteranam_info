import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/discounts/bloc/config/discount_config_cubit.dart';
import 'package:veteranam/shared/extension/extension_flutter_constants.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.discount} ', () {
    late IDiscountRepository mockDiscountRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late IReportRepository mockReportRepository;
    late AuthenticationRepository mockAuthenticationRepository;
    late FirebaseAnalyticsService mockFirebaseAnalyticsService;
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;
    late AppInfoRepository mockBuildRepository;
    late UserRepository mockUserRepository;

    void setUpTest() {
      // KTest.animatioRepeat=1;
      ExtendedDateTime.id = KTestVariables.id;
      ExtendedDateTime.current = KTestVariables.dateTime;
      PlatformEnumFlutter.isWebDesktop = true;
      mockDiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      mockAuthenticationRepository = MockAuthenticationRepository();
      mockFirebaseAnalyticsService = MockFirebaseAnalyticsService();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
      mockReportRepository = MockIReportRepository();
      mockBuildRepository = MockAppInfoRepository();
      mockUserRepository = MockUserRepository();

      when(mockFirebaseRemoteConfigProvider.waitActivated()).thenAnswer(
        (invocation) async => true,
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
      when(
        mockDiscountRepository.getDiscountItems(
          showOnlyBusinessDiscounts: false,
          // reportIdItems: KTestVariables.reportItems.getIdCard,
        ),
      ).thenAnswer(
        (invocation) => Stream.value(KTestVariables.discountModelItemsModify),
      );
      when(mockDiscountRepository.sendLink(KTestVariables.linkModel))
          .thenAnswer(
        (invocation) async => const Right(true),
      );
      when(mockDiscountRepository.sendEmail(KTestVariables.emailModel))
          .thenAnswer(
        (invocation) async => const Right(true),
      );

      when(
        mockFirebaseRemoteConfigProvider
            .getBool(DiscountConfigCubit.mobFilterEnhancedMobileKey),
      ).thenAnswer(
        (invocation) => false,
      );
    }

    group('Advanced filter reset mobile', () {
      setUp(setUpTest);

      testWidgets('Widget Test', (tester) async {
        await discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          mockReportRepository: mockReportRepository,
          mockBuildRepository: mockBuildRepository,
          mockUserRepository: mockUserRepository,
          mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockMobileRatingRepository: null,
        );

        await advancedFilterResetMobHelper(
          tester,
        );
      });
    });
    group('Advanced Filter Applied', () {
      setUp(setUpTest);
      testWidgets('Widget Test', (tester) async {
        await discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockReportRepository: mockReportRepository,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
          mockBuildRepository: mockBuildRepository,
          mockUserRepository: mockUserRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockMobileRatingRepository: null,
        );

        await advancedFilterAppliedHelper(tester);
      });
    });
    group('Advanced Filter Open Confirms Dialog', () {
      setUp(setUpTest);

      testWidgets('Widget Test', (tester) async {
        await discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockReportRepository: mockReportRepository,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
          mockBuildRepository: mockBuildRepository,
          mockUserRepository: mockUserRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockMobileRatingRepository: null,
        );

        await advancedFilterMobLocationTopTapHelper(tester);
      });
    });

    group('Advanced Filter Close Open Items Helper', () {
      setUp(setUpTest);

      testWidgets('Widget Test', (tester) async {
        await discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockReportRepository: mockReportRepository,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
          mockBuildRepository: mockBuildRepository,
          mockUserRepository: mockUserRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockMobileRatingRepository: null,
        );

        await advancedFilterCloseOpenItemsHelper(tester);
      });
    });

    group('Advanced Filter Close Open Cities Items Helper', () {
      setUp(setUpTest);

      testWidgets('Widget Test', (tester) async {
        await discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockReportRepository: mockReportRepository,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
          mockBuildRepository: mockBuildRepository,
          mockUserRepository: mockUserRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockMobileRatingRepository: null,
        );

        await advancedFilterCloseOpenCitiesItemsHelper(tester);
      });
    });
  });
}
