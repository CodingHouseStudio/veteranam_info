import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
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
            // reportIdItems: KTestText.reportItems.getIdCard,
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
          card: KWidgetkeys.screen.discounts.card,
          buttonMock: null,
          hasShimmer: true,
        );
      });
    });
    // group('${KGroupText.getEmptyList} ', () {
    //   setUp(() {
    //     when(
    //       mockDiscountRepository.getDiscountItems(
    //           // reportIdItems: KTestText.reportItems.getIdCard,
    //           ),
    //     ).thenAnswer(
    //       (invocation) => Stream.value([]),
    //     );
    //     when(mockDiscountRepository.addMockDiscountItems()).thenAnswer(
    //       (invocation) {},
    //     );
    //     if (GetIt.I.isRegistered<IDiscountRepository>()) {
    //       GetIt.I.unregister<IDiscountRepository>();
    //     }
    //     GetIt.I.registerSingleton<IDiscountRepository>
    // (mockDiscountRepository);
    //   });
    //   testWidgets('${KGroupText.mockButton} ', (tester) async {
    //     await discountsPumpAppHelper(
    //       tester: tester,
    //       mockDiscountRepository: mockDiscountRepository,
    //       mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    //       mockReportRepository: mockReportRepository,
    //       mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
    //       mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
    //       mockBuildRepository: mockBuildRepository,
    //  mockUserRepository: mockUserRepository,
    // mockAuthenticationRepository: mockAuthenticationRepository,
    //       mockMobileRatingRepository: null,
    //     );

    //     await mockButtonHelper(
    //       tester: tester,
    //       card: KWidgetkeys.screen.discounts.card,
    //       buttonMock: KWidgetkeys.screen.discounts.buttonMock,
    //     );
    //   });
    // });
    group('${KGroupText.getList} ', () {
      setUp(() {
        when(
          mockDiscountRepository.getDiscountItems(
            showOnlyBusinessDiscounts: false,
            // reportIdItems: KTestText.reportItems.getIdCard,
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
        // lastCard: KWidgetkeys.screen.discounts.cardLast,
      );

      // testWidgets('Report Dialog Check Point Failure', (tester) async {
      //   await discountsPumpAppHelper(
      //     tester: tester,
      //     mockDiscountRepository: mockDiscountRepository,
      //     mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      //     mockReportRepository: mockReportRepository,
      //     mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      //     mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
      //     mockBuildRepository: mockBuildRepository,
      //     mockUserRepository: mockUserRepository,
      //     mockAuthenticationRepository: mockAuthenticationRepository,
      //     mockMobileRatingRepository: null,
      //   );

      //   await reportDialogCheckFailureHelper(tester);
      // });
      testWidgets('Notification Link Correct Send', (tester) async {
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

        await discountsScrollHelper(
          tester: tester,
          test: notificationLinkCorrectHelper,
          isDesk: false,
        );
      });
      // testWidgets('Notification Link Wrong Send', (tester) async {
      //   await discountsPumpAppHelper(
      //     tester: tester,
      //     mockDiscountRepository: mockDiscountRepository,
      //     mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      //     mockReportRepository: mockReportRepository,
      //     mockAuthenticationRepository: mockAuthenticationRepository,
      //   );
      //   await discountsScrollHelper(
      //mockUserRepository: mockUserRepository,     tester: tester,
      //     test: notificationLinkWrongHelper,
      //   );
      // });

      // group(
      //   'Notification Link Limited',
      //   () {
      //     setUp(
      //       () =>
      //           when(mockDiscountRepository.
      // userCanSendLink(KTestText.user.id))
      //               .thenAnswer(
      //         (invocation) async => const Right(false),
      //       ),
      //     );

      //     testWidgets("User Can't Send Link", (tester) async {
      //       await discountsPumpAppHelper(
      //         tester: tester,
      //         mockDiscountRepository: mockDiscountRepository,
      //         mockAppAuthenticationRepository:
      // mockAppAuthenticationRepository,
      //         mockReportRepository: mockReportRepository,
      //         mockFirebaseRemoteConfigProvider:
      //             mockFirebaseRemoteConfigProvider,
      //         mockBuildRepository: mockBuildRepository,
      //         mockUserRepository: mockUserRepository,
      //         mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
      //         mockAuthenticationRepository: mockAuthenticationRepository,
      //         mockMobileRatingRepository: null,
      //       );
      //       await discountsScrollHelper(
      //         tester: tester,
      //         // itemKey: KWidgetkeys.widget.notificationLink.limitText,
      //         test: (WidgetTester tester) async => expect(
      //           find.byKey(KWidgetkeys.widget.notificationLink.thankText),
      //           findsOneWidget,
      //         ),
      //       );
      //     });
      //   },
      // );

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
        // testWidgets('Advanced filter reset mobile', (tester) async {
        //   await discountsPumpAppHelper(
        //     tester: tester,
        //     mockDiscountRepository: mockDiscountRepository,
        //     mockGoRouter: mockGoRouter,
        //     mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        //     mockFirebaseRemoteConfigProvider:
        // mockFirebaseRemoteConfigProvider,
        //     mockReportRepository: mockReportRepository,
        //     mockBuildRepository: mockBuildRepository,
        //     mockUserRepository: mockUserRepository,
        //     mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
        //     mockAuthenticationRepository: mockAuthenticationRepository,
        //     mockMobileRatingRepository: null,
        //   );

        //   await advancedFilterResetMobHelper(
        //     tester: tester,
        //     mockGoRouter: mockGoRouter,
        //   );
        // });
        // testWidgets('Report Dialog Incorect Send', (tester) async {
        //   await discountsPumpAppHelper(
        //     tester: tester,
        //     mockDiscountRepository: mockDiscountRepository,
        //     mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        //     mockReportRepository: mockReportRepository,
        //     mockFirebaseRemoteConfigProvider:
        // mockFirebaseRemoteConfigProvider,
        //     mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
        //     mockBuildRepository: mockBuildRepository,
        //     mockUserRepository: mockUserRepository,
        //     mockAuthenticationRepository: mockAuthenticationRepository,
        //     mockGoRouter: mockGoRouter,
        //     mockMobileRatingRepository: null,
        //   );

        //   await reportDialogIncorrectSendHelper(
        //     tester: tester,
        //     mockGoRouter: mockGoRouter,
        //   );
        // });
        // testWidgets('Report Dialog Incorect Send(field null and user)',
        //     (tester) async {
        //   // when(mockUserRepository.isAnonymously).thenAnswer(
        //   //   (realInvocation) => false,
        //   // );

        //   await discountsPumpAppHelper(
        //     tester: tester,
        //     mockDiscountRepository: mockDiscountRepository,
        //     mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        //     mockReportRepository: mockReportRepository,
        //     mockFirebaseRemoteConfigProvider:
        // mockFirebaseRemoteConfigProvider,
        //     mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
        //     mockBuildRepository: mockBuildRepository,
        //     mockUserRepository: mockUserRepository,
        //     mockAuthenticationRepository: mockAuthenticationRepository,
        //     mockGoRouter: mockGoRouter,
        //     mockMobileRatingRepository: null,
        //   );

        //   await reportDialogIncorrectSendHelper(
        //     tester: tester,
        //     fieldNull: true,
        //     mockGoRouter: mockGoRouter,
        //   );
        // });
        // testWidgets('Report Dialog Incorect Send(field null)',
        // (tester) async {
        //   await discountsPumpAppHelper(
        //     tester: tester,
        //     mockDiscountRepository: mockDiscountRepository,
        //     mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        //     mockReportRepository: mockReportRepository,
        //     mockFirebaseRemoteConfigProvider:
        // mockFirebaseRemoteConfigProvider,
        //     mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
        //     mockBuildRepository: mockBuildRepository,
        //     mockUserRepository: mockUserRepository,
        //     mockAuthenticationRepository: mockAuthenticationRepository,
        //     mockGoRouter: mockGoRouter,
        //     mockMobileRatingRepository: null,
        //   );

        //   await reportDialogIncorrectSendHelper(
        //     tester: tester,
        //     fieldNull: true,
        //     mockGoRouter: mockGoRouter,
        //   );
        // });
        group('${KGroupText.goTo} ', () {
          group('${Config.business} ', () {
            setUp(
              () => Config.roleValue = Config.business,
            );
            // testWidgets('${KRoute.myDiscounts.name} ', (tester) async {
            //   await discountsPumpAppHelper(
            //     tester: tester,
            //     mockDiscountRepository: mockDiscountRepository,
            //     mockGoRouter: mockGoRouter,
            //     mockAppAuthenticationRepository:
            //         mockAppAuthenticationRepository,
            //     mockFirebaseRemoteConfigProvider:
            //         mockFirebaseRemoteConfigProvider,
            //     mockUserRepository: mockUserRepository,
            //     mockBuildRepository: mockBuildRepository,
            //     mockReportRepository: mockReportRepository,
            //     mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
            //     mockAuthenticationRepository: mockAuthenticationRepository,
            //     mockMobileRatingRepository: null,
            //   );

            //   await myDiscountHelper(
            //     tester: tester,
            //     mockGoRouter: mockGoRouter,
            //   );
            // });
            // testWidgets('Dialog pop to ${KRoute.discounts.name} ',
            //     (tester) async {
            //   await discountsPumpAppHelper(
            //     tester: tester,
            //     mockDiscountRepository: mockDiscountRepository,
            //     mockGoRouter: mockGoRouter,
            //     mockAppAuthenticationRepository:
            //         mockAppAuthenticationRepository,
            //     mockFirebaseRemoteConfigProvider:
            //         mockFirebaseRemoteConfigProvider,
            //     mockUserRepository: mockUserRepository,
            //     mockBuildRepository: mockBuildRepository,
            //     mockReportRepository: mockReportRepository,
            //     mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
            //     mockAuthenticationRepository: mockAuthenticationRepository,
            //     mockMobileRatingRepository: null,
            //   );

            //   await advancedFilterAppliedHelper(
            //     tester: tester,
            //     mockGoRouter: mockGoRouter,
            //   );
            // });
          });
        });

        // group('User email dialog', () {
        //   setUp(
        //     () {
        //       when(
        //         mockDiscountRepository.userCanSendUserEmail
        // (KTestText.user.id),
        //       ).thenAnswer(
        //         (invocation) async => const Right(0),
        //       );
        //     },
        //   );
        //   testWidgets('User email dialog', (tester) async {
        //     await discountsPumpAppHelper(
        //       tester: tester,
        //       mockDiscountRepository: mockDiscountRepository,
        //       mockGoRouter: mockGoRouter,
        //       mockAppAuthenticationRepository:
        // mockAppAuthenticationRepository,
        //       mockFirebaseRemoteConfigProvider:
        //           mockFirebaseRemoteConfigProvider,
        //       mockBuildRepository: mockBuildRepository,
        //       mockUserRepository: mockUserRepository,
        //       mockReportRepository: mockReportRepository,
        //       mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
        //       mockAuthenticationRepository: mockAuthenticationRepository,
        //       mockMobileRatingRepository: null,
        //     );

        //     await discountsScrollHelper(
        //       tester: tester,
        //       test: (tester) async => userEmailCorrectHelper(
        //         tester: tester,
        //         mockGoRouter: mockGoRouter,
        //       ),
        //       showEmailDialog: true,
        //     );
        //   });
        //   testWidgets('User email dialog close', (tester) async {
        //     await discountsPumpAppHelper(
        //       tester: tester,
        //       mockDiscountRepository: mockDiscountRepository,
        //       mockGoRouter: mockGoRouter,
        //       mockAppAuthenticationRepository:
        // mockAppAuthenticationRepository,
        //       mockFirebaseRemoteConfigProvider:
        //           mockFirebaseRemoteConfigProvider,
        //       mockBuildRepository: mockBuildRepository,
        //       mockUserRepository: mockUserRepository,
        //       mockReportRepository: mockReportRepository,
        //       mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
        //       mockAuthenticationRepository: mockAuthenticationRepository,
        //       mockMobileRatingRepository: null,
        //     );

        //     await discountsScrollHelper(
        //       tester: tester,
        //       test: (tester) async => userEmailCloseHelper(
        //         tester: tester,
        //         mockGoRouter: mockGoRouter,
        //       ),
        //       showEmailDialog: true,
        //     );
        //   });
        //   testWidgets('User email dialog empty', (tester) async {
        //     await discountsPumpAppHelper(
        //       tester: tester,
        //       mockDiscountRepository: mockDiscountRepository,
        //       mockGoRouter: mockGoRouter,
        //       mockAppAuthenticationRepository:
        // mockAppAuthenticationRepository,
        //       mockFirebaseRemoteConfigProvider:
        //           mockFirebaseRemoteConfigProvider,
        //       mockBuildRepository: mockBuildRepository,
        //       mockUserRepository: mockUserRepository,
        //       mockReportRepository: mockReportRepository,
        //       mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
        //       mockAuthenticationRepository: mockAuthenticationRepository,
        //       mockMobileRatingRepository: null,
        //     );

        //     await discountsScrollHelper(
        //       tester: tester,
        //       test: userEmailEmptyHelper,
        //       showEmailDialog: true,
        //     );
        //   });
        //   testWidgets('User email dialog wrong', (tester) async {
        //     await discountsPumpAppHelper(
        //       tester: tester,
        //       mockDiscountRepository: mockDiscountRepository,
        //       mockGoRouter: mockGoRouter,
        //       mockAppAuthenticationRepository:
        // mockAppAuthenticationRepository,
        //       mockFirebaseRemoteConfigProvider:
        //           mockFirebaseRemoteConfigProvider,
        //       mockBuildRepository: mockBuildRepository,
        //       mockUserRepository: mockUserRepository,
        //       mockReportRepository: mockReportRepository,
        //       mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
        //       mockAuthenticationRepository: mockAuthenticationRepository,
        //       mockMobileRatingRepository: null,
        //     );

        //     await discountsScrollHelper(
        //       tester: tester,
        //       test: (tester) async => userEmailWrongHelper(
        //         tester: tester,
        //         mockGoRouter: mockGoRouter,
        //       ),
        //       showEmailDialog: true,
        //     );
        //   });

        //   group('${KGroupText.failureGet} ', () {
        //     setUp(
        //       () {
        //         when(
        //           mockDiscountRepository.sendEmail(KTestText.emailModel),
        //         ).thenAnswer(
        //           (invocation) async => Left(
        //             SomeFailure.serverError(
        //               error: null,
        //             ),
        //           ),
        //         );
        //       },
        //     );
        //     testWidgets('User email dialog incorect', (tester) async {
        //       await discountsPumpAppHelper(
        //         tester: tester,
        //         mockDiscountRepository: mockDiscountRepository,
        //         mockGoRouter: mockGoRouter,
        //         mockAppAuthenticationRepository:
        //             mockAppAuthenticationRepository,
        //         mockBuildRepository: mockBuildRepository,
        //         mockUserRepository: mockUserRepository,
        //         mockFirebaseRemoteConfigProvider:
        //             mockFirebaseRemoteConfigProvider,
        //         mockReportRepository: mockReportRepository,
        //         mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
        //         mockAuthenticationRepository: mockAuthenticationRepository,
        //         mockMobileRatingRepository: null,
        //       );

        //       await discountsScrollHelper(
        //         tester: tester,
        //         test: (tester) async => userEmailCorrectHelper(
        //           tester: tester,
        //           mockGoRouter: mockGoRouter,
        //         ),
        //         showEmailDialog: true,
        //       );
        //     });
        //   });
        // });
        // group('User email dialog', () {
        //   setUp(
        //     () {
        //       when(
        //         mockDiscountRepository.userCanSendUserEmail
        // (KTestText.user.id),
        //       ).thenAnswer(
        //         (invocation) async => const Right(4),
        //       );
        //     },
        //   );
        //   testWidgets('User email dialog', (tester) async {
        //     await discountsPumpAppHelper(
        //       tester: tester,
        //       mockDiscountRepository: mockDiscountRepository,
        //       mockGoRouter: mockGoRouter,
        //       mockAppAuthenticationRepository:
        // mockAppAuthenticationRepository,
        //       mockFirebaseRemoteConfigProvider:
        //           mockFirebaseRemoteConfigProvider,
        //       mockBuildRepository: mockBuildRepository,
        //       mockUserRepository: mockUserRepository,
        //       mockReportRepository: mockReportRepository,
        //       mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
        //       mockAuthenticationRepository: mockAuthenticationRepository,
        //       mockMobileRatingRepository: null,
        //     );

        //     await discountsScrollHelper(
        //       tester: tester,
        //       test: (tester) async => userEmailCloseDelayHelper(
        //         tester: tester,
        //         mockGoRouter: mockGoRouter,
        //       ),
        //       showEmailDialog: true,
        //     );
        //   });
        // });
      });
    });
  });
}
