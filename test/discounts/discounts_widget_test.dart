import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
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
    setUp(() {
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
    });
    group('${KGroupText.failure} ', () {
      late StreamController<List<DiscountModel>> failureStream;
      setUp(() {
        failureStream = StreamController<List<DiscountModel>>()..add([]);
        when(
          mockDiscountRepository.getDiscountItems(
            showOnlyBusinessDiscounts: false,
            // reportIdItems: KTestVariables.reportItems.getIdCard,
          ),
        ).thenAnswer(
          (invocation) => failureStream.stream,
        );
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
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

        failureStream.addError(KGroupText.failureGet);
        await tester.pump(const Duration(seconds: 20));
        await failureStream.close();
        failureStream = StreamController<List<DiscountModel>>()..add([]);

        await loadingFailureHelper(
          tester: tester,
          card: DiscountsKeys.card,
          buttonMock: null,
          hasShimmer: true,
        );
      });
    });
    group('${KGroupText.getList} ', () {
      setUp(() {
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
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
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

        await discountsInitialHelper(tester);
      });

      loadingList(
        (tester) async => discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockReportRepository: mockReportRepository,
          mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockBuildRepository: mockBuildRepository,
          mockMobileRatingRepository: null,
          mockUserRepository: mockUserRepository,
        ),
        // lastCard: DiscountsKeys.cardLast,
      );

      testWidgets('${KGroupText.network} ', (tester) async {
        await networkHelper(
          tester: tester,
          pumpApp: () async => discountsPumpAppHelper(
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
          ),
        );

        verify(
          mockDiscountRepository.getDiscountItems(
            showOnlyBusinessDiscounts: false,
          ),
        ).called(1);
      });

      group('Loading Delay', () {
        setUp(() {
          KTest.testLoading = true;
        });
        testWidgets('Loading', (tester) async {
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

          await discountsLoadingHelper(tester);
        });
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
            mockBuildRepository: mockBuildRepository,
            mockUserRepository: mockUserRepository,
            mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
            mockAuthenticationRepository: mockAuthenticationRepository,
            mockMobileRatingRepository: null,
          );

          await discountsInitialHelper(tester);
        });
        testWidgets('Advanced filter reset mobile', (tester) async {
          await discountsPumpAppHelper(
            tester: tester,
            mockDiscountRepository: mockDiscountRepository,
            mockGoRouter: mockGoRouter,
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
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
