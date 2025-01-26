import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/extension/extension_flutter_constants.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';
import '../helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.discount} ', () {
    setUp(() {
      PlatformEnumFlutter.isWebDesktop = true;
      discountsWidgetTestRegister();

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
    });

    testWidgets('Report Dialog Check Point Failure', (tester) async {
      await discountsPumpAppHelper(
        tester,
      );

      await reportDialogCheckFailureHelper(
        tester: tester,
        popupMenuKey: DiscountCardKeys.popupMenuButton,
      );
    });
    testWidgets('Notification Link Correct Send', (tester) async {
      await discountsPumpAppHelper(
        tester,
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

    group(
      'Notification Link Limited',
      () {
        setUp(
          () => when(
            mockDiscountRepository.userCanSendLink(KTestVariables.user.id),
          ).thenAnswer(
            (invocation) async => const Right(false),
          ),
        );

        testWidgets("User Can't Send Link", (tester) async {
          await discountsPumpAppHelper(
            tester,
          );
          await discountsScrollHelper(
            tester: tester,
            // itemKey: NotificationLinkKeys.limitText,
            test: (WidgetTester tester) async => expect(
              find.byKey(NotificationLinkKeys.thankText),
              findsOneWidget,
            ),
          );
        });
      },
    );

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());

      testWidgets('Report Dialog Incorect Send', (tester) async {
        await discountsPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await reportDialogIncorrectSendHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          popupMenuKey: DiscountCardKeys.popupMenuButton,
        );
      });
      testWidgets('Report Dialog Incorect Send(field null and user)',
          (tester) async {
        // when(mockUserRepository.isAnonymously).thenAnswer(
        //   (realInvocation) => false,
        // );

        await discountsPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await reportDialogIncorrectSendHelper(
          tester: tester,
          fieldNull: true,
          mockGoRouter: mockGoRouter,
          popupMenuKey: DiscountCardKeys.popupMenuButton,
        );
      });
      testWidgets('Report Dialog Incorect Send(field null)', (tester) async {
        await discountsPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await reportDialogIncorrectSendHelper(
          tester: tester,
          fieldNull: true,
          mockGoRouter: mockGoRouter,
          popupMenuKey: DiscountCardKeys.popupMenuButton,
        );
      });

      group('User email dialog', () {
        setUp(
          () {
            when(
              mockDiscountRepository
                  .userCanSendUserEmail(KTestVariables.user.id),
            ).thenAnswer(
              (invocation) async => const Right(0),
            );
          },
        );
        testWidgets('${KGroupText.initial} ', (tester) async {
          await discountsPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
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
            tester,
            mockGoRouter: mockGoRouter,
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
            tester,
            mockGoRouter: mockGoRouter,
          );

          await discountsScrollHelper(
            tester: tester,
            test: userEmailEmptyHelper,
            showEmailDialog: true,
          );
        });
        testWidgets('User email dialog wrong', (tester) async {
          await discountsPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
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
                mockDiscountRepository.sendEmail(KTestVariables.emailModel),
              ).thenAnswer(
                (invocation) async => const Left(
                  SomeFailure.serverError,
                ),
              );
            },
          );
          testWidgets('User email dialog incorect', (tester) async {
            await discountsPumpAppHelper(
              tester,
              mockGoRouter: mockGoRouter,
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
      group('User email dialog', () {
        setUp(
          () {
            when(
              mockDiscountRepository
                  .userCanSendUserEmail(KTestVariables.user.id),
            ).thenAnswer(
              (invocation) async => const Right(4),
            );
          },
        );
        testWidgets('User email dialog', (tester) async {
          await discountsPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await discountsScrollHelper(
            tester: tester,
            test: (tester) async => userEmailCloseDelayHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            ),
            showEmailDialog: true,
          );
        });
      });
    });
  });
}
