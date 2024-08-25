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
  group('${KScreenBlocName.discount} ', () {
    late IDiscountRepository mockDiscountRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late IReportRepository mockReportRepository;
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.id = KTestText.id;
      ExtendedDateTime.current = KTestText.dateTime;
      KPlatformConstants.isWebDesktop = true;
      mockDiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      mockAuthenticationRepository = MockAuthenticationRepository();

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
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(
          mockDiscountRepository.getDiscountItems(
            reportIdItems: KTestText.reportItems.getIdCard,
          ),
        ).thenAnswer(
          (invocation) => Stream.error(Exception(KGroupText.failureGet)),
        );
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
        await discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockReportRepository: mockReportRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await loadingFailureHelper(
          tester: tester,
          card: KWidgetkeys.screen.discounts.card,
          buttonMock: KWidgetkeys.screen.discounts.buttonMock,
        );
      });
    });
    group('${KGroupText.getEmptyList} ', () {
      setUp(() {
        when(
          mockDiscountRepository.getDiscountItems(
            reportIdItems: KTestText.reportItems.getIdCard,
          ),
        ).thenAnswer(
          (invocation) => Stream.value([]),
        );
        when(mockDiscountRepository.addMockDiscountItems()).thenAnswer(
          (invocation) {},
        );
        if (GetIt.I.isRegistered<IDiscountRepository>()) {
          GetIt.I.unregister<IDiscountRepository>();
        }
        GetIt.I.registerSingleton<IDiscountRepository>(mockDiscountRepository);
      });
      testWidgets('${KGroupText.mockButton} ', (tester) async {
        await discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockReportRepository: mockReportRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await mockButtonHelper(
          tester: tester,
          card: KWidgetkeys.screen.discounts.card,
          buttonMock: KWidgetkeys.screen.discounts.buttonMock,
        );
      });
    });
    group('${KGroupText.getList} ', () {
      setUp(() {
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
        );

        await discountsInitialHelper(tester);
      });

      loadingList(
        (tester) async => discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockReportRepository: mockReportRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
        ),
        // lastCard: KWidgetkeys.screen.discounts.cardLast,
      );

      testWidgets('Report Dialog Check Point Failure', (tester) async {
        await discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockReportRepository: mockReportRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await reportDialogCheckFailureHelper(tester);
      });
      // testWidgets('Report Dialog Incorect Send', (tester) async {
      //   await discountsPumpAppHelper(
      //     tester: tester,
      //     mockDiscountRepository: mockDiscountRepository,
      //     mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      //     mockReportRepository: mockReportRepository,
      //     mockAuthenticationRepository: mockAuthenticationRepository,
      //   );

      //   await reportDialogIncorrectSendHelper(
      //     tester: tester,
      //   );
      // });
      // testWidgets('Report Dialog Incorect Send(field null and user)',
      //     (tester) async {
      //   when(mockAuthenticationRepository.isAnonymouslyOrEmty()).thenAnswer(
      //     (realInvocation) => false,
      //   );

      //   await discountsPumpAppHelper(
      //     tester: tester,
      //     mockDiscountRepository: mockDiscountRepository,
      //     mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      //     mockReportRepository: mockReportRepository,
      //     mockAuthenticationRepository: mockAuthenticationRepository,
      //   );

      //   await reportDialogIncorrectSendHelper(
      //     tester: tester,
      //     fieldNull: true,
      //   );
      // });
      // testWidgets('Report Dialog Incorect Send(field null)', (tester) async {
      //   await discountsPumpAppHelper(
      //     tester: tester,
      //     mockDiscountRepository: mockDiscountRepository,
      //     mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      //     mockReportRepository: mockReportRepository,
      //     mockAuthenticationRepository: mockAuthenticationRepository,
      //   );

      //   await reportDialogIncorrectSendHelper(
      //     tester: tester,
      //     fieldNull: true,
      //   );
      // });
      testWidgets('Notification Link Correct Send', (tester) async {
        await discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockReportRepository: mockReportRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
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
      //     tester: tester,
      //     test: notificationLinkWrongHelper,
      //   );
      // });

      group(
        'Notification Link Limited',
        () {
          setUp(
            () =>
                when(mockDiscountRepository.userCanSendLink(KTestText.user.id))
                    .thenAnswer(
              (invocation) async => const Right(false),
            ),
          );

          testWidgets("User Can't Send Link", (tester) async {
            await discountsPumpAppHelper(
              tester: tester,
              mockDiscountRepository: mockDiscountRepository,
              mockAppAuthenticationRepository: mockAppAuthenticationRepository,
              mockReportRepository: mockReportRepository,
              mockAuthenticationRepository: mockAuthenticationRepository,
            );
            await discountsScrollHelper(
              tester: tester,
              // itemKey: KWidgetkeys.widget.notificationLink.limitText,
              test: (WidgetTester tester) async => expect(
                find.byKey(KWidgetkeys.widget.notificationLink.thankText),
                findsOneWidget,
              ),
            );
          });
        },
      );

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
          );

          await discountsInitialHelper(tester);
        });
        testWidgets('Advanced filter reset mobile', (tester) async {
          await discountsPumpAppHelper(
            tester: tester,
            mockDiscountRepository: mockDiscountRepository,
            mockGoRouter: mockGoRouter,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockReportRepository: mockReportRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
          );

          await advancedFilterResetMobHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
        group('${KGroupText.goTo} ', () {
          testWidgets('${KRoute.myDiscounts.name} ', (tester) async {
            await discountsPumpAppHelper(
              tester: tester,
              mockDiscountRepository: mockDiscountRepository,
              mockGoRouter: mockGoRouter,
              mockAppAuthenticationRepository: mockAppAuthenticationRepository,
              mockReportRepository: mockReportRepository,
              mockAuthenticationRepository: mockAuthenticationRepository,
            );

            await myDiscountHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });
          testWidgets('Dialog pop to ${KRoute.discounts.name} ',
              (tester) async {
            await discountsPumpAppHelper(
              tester: tester,
              mockDiscountRepository: mockDiscountRepository,
              mockGoRouter: mockGoRouter,
              mockAppAuthenticationRepository: mockAppAuthenticationRepository,
              mockReportRepository: mockReportRepository,
              mockAuthenticationRepository: mockAuthenticationRepository,
            );

            await advancedFilterAppliedHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });
        });

        group('User email dialog', () {
          setUp(
            () {
              when(
                mockDiscountRepository.userCanSendUserEmail(KTestText.user.id),
              ).thenAnswer(
                (invocation) async => const Right(true),
              );
            },
          );
          testWidgets('User email dialog', (tester) async {
            await discountsPumpAppHelper(
              tester: tester,
              mockDiscountRepository: mockDiscountRepository,
              mockGoRouter: mockGoRouter,
              mockAppAuthenticationRepository: mockAppAuthenticationRepository,
              mockReportRepository: mockReportRepository,
              mockAuthenticationRepository: mockAuthenticationRepository,
            );

            await discountsScrollHelper(
              tester: tester,
              test: (tester) async => userEmailCorrectHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
              ),
              showEmailDialog: true,
            );
          });
          testWidgets('User email dialog close', (tester) async {
            await discountsPumpAppHelper(
              tester: tester,
              mockDiscountRepository: mockDiscountRepository,
              mockGoRouter: mockGoRouter,
              mockAppAuthenticationRepository: mockAppAuthenticationRepository,
              mockReportRepository: mockReportRepository,
              mockAuthenticationRepository: mockAuthenticationRepository,
            );

            await discountsScrollHelper(
              tester: tester,
              test: (tester) async => userEmailCloseHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
              ),
              showEmailDialog: true,
            );
          });
          testWidgets('User email dialog empty', (tester) async {
            await discountsPumpAppHelper(
              tester: tester,
              mockDiscountRepository: mockDiscountRepository,
              mockGoRouter: mockGoRouter,
              mockAppAuthenticationRepository: mockAppAuthenticationRepository,
              mockReportRepository: mockReportRepository,
              mockAuthenticationRepository: mockAuthenticationRepository,
            );

            await discountsScrollHelper(
              tester: tester,
              test: userEmailEmptyHelper,
              showEmailDialog: true,
            );
          });
          testWidgets('User email dialog wrong', (tester) async {
            await discountsPumpAppHelper(
              tester: tester,
              mockDiscountRepository: mockDiscountRepository,
              mockGoRouter: mockGoRouter,
              mockAppAuthenticationRepository: mockAppAuthenticationRepository,
              mockReportRepository: mockReportRepository,
              mockAuthenticationRepository: mockAuthenticationRepository,
            );

            await discountsScrollHelper(
              tester: tester,
              test: (tester) async => userEmailWrongHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
              ),
              showEmailDialog: true,
            );
          });

          group('${KGroupText.failureGet} ', () {
            setUp(
              () {
                when(
                  mockDiscountRepository.sendEmail(KTestText.emailModel),
                ).thenAnswer(
                  (invocation) async => const Left(SomeFailure.serverError()),
                );
              },
            );
            testWidgets('User email dialog incorect', (tester) async {
              await discountsPumpAppHelper(
                tester: tester,
                mockDiscountRepository: mockDiscountRepository,
                mockGoRouter: mockGoRouter,
                mockAppAuthenticationRepository:
                    mockAppAuthenticationRepository,
                mockReportRepository: mockReportRepository,
                mockAuthenticationRepository: mockAuthenticationRepository,
              );

              await discountsScrollHelper(
                tester: tester,
                test: (tester) async => userEmailCorrectHelper(
                  tester: tester,
                  mockGoRouter: mockGoRouter,
                ),
                showEmailDialog: true,
              );
            });
          });
        });
      });
    });
  });
}
