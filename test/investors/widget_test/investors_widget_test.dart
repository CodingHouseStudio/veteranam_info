import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';
import '../helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.investors} ', () {
    setUp(investorsWidgetTestRegister);
    group('${KGroupText.failure} ', () {
      testWidgets('${KGroupText.error} ', (tester) async {
        when(
          mockInvestorsRepository.getFunds(
              // reportIdItems: KTestVariables.reportItems.getIdCard,
              ),
        ).thenAnswer((invocation) async {
          await KTestConstants.delay;
          return const Left(SomeFailure.serverError);
        });
        await investorsPumpAppHelper(
          tester,
        );

        await investorsFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureNetwork} ', (tester) async {
        when(
          mockInvestorsRepository.getFunds(
              // reportIdItems: KTestVariables.reportItems.getIdCard,
              ),
        ).thenAnswer(
          (invocation) async {
            await KTestConstants.delay;
            return const Left(SomeFailure.network);
          },
        );
        await investorsPumpAppHelper(
          tester,
        );

        await investorsFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
        when(
          mockInvestorsRepository.getFunds(
              // reportIdItems: KTestVariables.reportItems.getIdCard,
              ),
        ).thenAnswer((invocation) async {
          await KTestConstants.delay;
          return const Left(SomeFailure.get);
        });
        await investorsPumpAppHelper(
          tester,
        );

        await investorsFailureHelper(tester);
      });
    });
    // group('${KGroupText.getEmptyList} ', () {
    //   setUp(() {
    //     when(
    //       mockInvestorsRepository.getFunds(
    //           // reportIdItems: KTestVariables.reportItems.getIdCard,
    //           ),
    //     ).thenAnswer(
    //       (invocation) async => const Right([]),
    //     );

    //     when(mockInvestorsRepository.addMockFunds()).thenAnswer(
    //       (invocation) {},
    //     );
    //     if (GetIt.I.isRegistered<IInvestorsRepository>()) {
    //       GetIt.I.unregister<IInvestorsRepository>();
    //     }
    //     GetIt.I.registerSingleton<IInvestorsRepository>(
    //       mockInvestorsRepository,
    //     );
    //   });
    // testWidgets('${KGroupText.mockButton} ', (tester) async {
    //   await investorsPumpAppHelper(
    //     mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    //     mockInvestorsRepository: mockInvestorsRepository,
    //     mockReportRepository: mockReportRepository,
    //     mockAuthenticationRepository: mockAuthenticationRepository,
    //     mockUrlRepository: mockUrlRepository,
    //     tester: tester,
    //   );

    //   await investorsMockButtonHelper(tester);
    // });
    // });
    group('${KGroupText.getList} ', () {
      setUp(() {
        when(
          mockInvestorsRepository.getFunds(
              // reportIdItems: KTestVariables.reportItems.getIdCard,
              ),
        ).thenAnswer(
          (invocation) async => Right(KTestVariables.fundItems),
        );
      });

      testWidgets('${KGroupText.initial} ', (tester) async {
        await investorsPumpAppHelper(
          tester,
        );

        await investorsInitialHelper(tester);
      });

      testWidgets('${KGroupText.network} ', (tester) async {
        await networkHelper(
          tester: tester,
          pumpApp: () async => investorsPumpAppHelper(
            tester,
          ),
        );

        verify(
          mockInvestorsRepository.getFunds(
              // reportIdItems: KTestVariables.reportItems.getIdCard,
              ),
        ).called(2);
      });

      // loadingList(
      //   (tester) async => investorsPumpAppHelper(
      //     mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      //     mockInvestorsRepository: mockInvestorsRepository,
      //     mockReportRepository: mockReportRepository,
      //     mockAuthenticationRepository: mockAuthenticationRepository,
      //     mockUrlRepository: mockUrlRepository,
      //     tester: tester,
      //   ),
      //   // lastCard: InvestorsKeys.cardLast,
      // );
      testWidgets('Report Dialog Check Point Failure', (tester) async {
        await investorsPumpAppHelper(
          tester,
        );

        await reportDialogCheckFailureHelper(
          tester: tester,
          popupMenuKey: null,
        );
      });
      // testWidgets('Report Dialog Incorect Send', (tester) async {
      //   await investorsPumpAppHelper(
      //     mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      //     mockInvestorsRepository: mockInvestorsRepository,
      //     mockReportRepository: mockReportRepository,
      //     mockAuthenticationRepository: mockAuthenticationRepository,
      //    mockUrlRepository: mockUrlRepository, tester: tester,
      //   );

      //   await reportDialogIncorrectSendHelper(
      //    mockUrlRepository: mockUrlRepository, tester: tester,
      //   );
      // });
      // testWidgets('Report Dialog Incorect Send(field null and user)',
      //     (tester) async {
      //   when(mockAuthenticationRepository.isAnonymouslyOrEmty).thenAnswer(
      //     (realInvocation) => false,
      //   );

      //   await investorsPumpAppHelper(
      //     mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      //     mockInvestorsRepository: mockInvestorsRepository,
      //     mockReportRepository: mockReportRepository,
      //     mockAuthenticationRepository: mockAuthenticationRepository,
      //    mockUrlRepository: mockUrlRepository, tester: tester,
      //   );

      //   await reportDialogIncorrectSendHelper(
      //    mockUrlRepository: mockUrlRepository, tester: tester,
      //     fieldNull: true,
      //   );
      // });
      // testWidgets('Report Dialog Incorect Send(field null)', (tester) async {
      //   await investorsPumpAppHelper(
      //     mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      //     mockInvestorsRepository: mockInvestorsRepository,
      //     mockReportRepository: mockReportRepository,
      //     mockAuthenticationRepository: mockAuthenticationRepository,
      //    mockUrlRepository: mockUrlRepository, tester: tester,
      //   );

      //   await reportDialogIncorrectSendHelper(
      //    mockUrlRepository: mockUrlRepository, tester: tester,
      //     fieldNull: true,
      //   );
      // });

      testWidgets('Donate button', (tester) async {
        await investorsPumpAppHelper(
          tester,
        );

        await donateButtonHelper(
          tester: tester,
          tap: true,
          scrollDown: true,
          isDesk: false,
        );
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await investorsPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await investorsInitialHelper(tester);
        });
        testWidgets('Report Dialog Correct Send', (tester) async {
          await investorsPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await reportDialogCorrectSaveHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            popupMenuKey: null,
          );
        });
        group('${KGroupText.goTo} ', () {
          testWidgets('nawbar widget navigation', (tester) async {
            await investorsPumpAppHelper(
              tester,
              mockGoRouter: mockGoRouter,
            );

            await feedbackNavigationHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });
        });
      });
      group('${KGroupText.smallList} ', () {
        setUp(() {
          when(
            mockInvestorsRepository.getFunds(
                // reportIdItems: KTestVariables.reportItems.getIdCard,
                ),
          ).thenAnswer(
            (invocation) async => Right(KTestVariables.fundItems.sublist(0, 2)),
          );
        });
        testWidgets('End list', (tester) async {
          await investorsPumpAppHelper(
            tester,
          );

          await investorsEndListHelper(tester);
        });
      });
    });
  });
}
