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
  group('${KScreenBlocName.investors} ', () {
    late IInvestorsRepository mockInvestorsRepository;
    late IReportRepository mockReportRepository;
    late AuthenticationRepository mockAuthenticationRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late IUrlRepository mockUrlRepository;
    setUp(() {
      ExtendedDateTime.current = KTestText.dateTime;
      ExtendedDateTime.id = '';
      KTest.testIsWeb = true;

      mockInvestorsRepository = MockIInvestorsRepository();
      mockReportRepository = MockIReportRepository();
      mockAuthenticationRepository = MockAuthenticationRepository();
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      mockUrlRepository = MockIUrlRepository();

      when(mockAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => User.empty,
      );
      when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => UserSetting.empty,
      );
      when(mockAuthenticationRepository.isAnonymouslyOrEmty()).thenAnswer(
        (realInvocation) => true,
      );
      when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => UserSetting.empty,
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => KTestText.user,
      );
      when(mockAppAuthenticationRepository.isAnonymously()).thenAnswer(
        (realInvocation) => true,
      );
      when(
        mockReportRepository.sendReport(
          KTestText.reportModel
              .copyWith(reasonComplaint: ReasonComplaint.other),
        ),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
      when(
        mockReportRepository.getCardReportById(
          cardEnum: CardEnum.funds,
          userId: KTestText.user.id,
        ),
      ).thenAnswer(
        (invocation) async => Right(KTestText.reportItems),
      );
      when(
        mockUrlRepository.launchUrl(
          url: KTestText.fundItems.first.projectsLink!,
        ),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
    });
    group('${KGroupText.failure} ', () {
      testWidgets('${KGroupText.error} ', (tester) async {
        when(
          mockInvestorsRepository.getFunds(
            reportIdItems: KTestText.reportItems.getIdCard,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.serverError()),
        );
        await investorsPumpAppHelper(
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockInvestorsRepository: mockInvestorsRepository,
          mockReportRepository: mockReportRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockUrlRepository: mockUrlRepository,
          tester: tester,
        );

        await investorsFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureNetwork} ', (tester) async {
        when(
          mockInvestorsRepository.getFunds(
            reportIdItems: KTestText.reportItems.getIdCard,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.network()),
        );
        await investorsPumpAppHelper(
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockInvestorsRepository: mockInvestorsRepository,
          mockReportRepository: mockReportRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockUrlRepository: mockUrlRepository,
          tester: tester,
        );

        await investorsFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
        when(
          mockInvestorsRepository.getFunds(
            reportIdItems: KTestText.reportItems.getIdCard,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.get()),
        );
        await investorsPumpAppHelper(
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockInvestorsRepository: mockInvestorsRepository,
          mockReportRepository: mockReportRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockUrlRepository: mockUrlRepository,
          tester: tester,
        );

        await investorsFailureHelper(tester);
      });
    });
    group('${KGroupText.getEmptyList} ', () {
      setUp(() {
        when(
          mockInvestorsRepository.getFunds(
            reportIdItems: KTestText.reportItems.getIdCard,
          ),
        ).thenAnswer(
          (invocation) async => const Right([]),
        );

        when(mockInvestorsRepository.addMockFunds()).thenAnswer(
          (invocation) {},
        );
        if (GetIt.I.isRegistered<IInvestorsRepository>()) {
          GetIt.I.unregister<IInvestorsRepository>();
        }
        GetIt.I.registerSingleton<IInvestorsRepository>(
          mockInvestorsRepository,
        );
      });
      testWidgets('${KGroupText.mockButton} ', (tester) async {
        await investorsPumpAppHelper(
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockInvestorsRepository: mockInvestorsRepository,
          mockReportRepository: mockReportRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockUrlRepository: mockUrlRepository,
          tester: tester,
        );

        await investorsMockButtonHelper(tester);
      });
    });
    group('${KGroupText.getList} ', () {
      setUp(() {
        when(
          mockInvestorsRepository.getFunds(
            reportIdItems: KTestText.reportItems.getIdCard,
          ),
        ).thenAnswer(
          (invocation) async => Right(KTestText.fundItems),
        );
      });

      testWidgets('${KGroupText.intial} ', (tester) async {
        await investorsPumpAppHelper(
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockInvestorsRepository: mockInvestorsRepository,
          mockReportRepository: mockReportRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockUrlRepository: mockUrlRepository,
          tester: tester,
        );

        await investorsInitialHelper(tester);
      });

      testWidgets('${KGroupText.network} ', (tester) async {
        await networkHelper(
          tester: tester,
          pumpApp: () async => investorsPumpAppHelper(
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockInvestorsRepository: mockInvestorsRepository,
            mockReportRepository: mockReportRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            mockUrlRepository: mockUrlRepository,
            tester: tester,
          ),
        );

        verify(
          mockInvestorsRepository.getFunds(
            reportIdItems: KTestText.reportItems.getIdCard,
          ),
        ).called(2);
      });

      loadingList(
        (tester) async => investorsPumpAppHelper(
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockInvestorsRepository: mockInvestorsRepository,
          mockReportRepository: mockReportRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockUrlRepository: mockUrlRepository,
          tester: tester,
        ),
        // lastCard: KWidgetkeys.screen.investors.cardLast,
      );
      testWidgets('Report Dialog Check Point Failure', (tester) async {
        await investorsPumpAppHelper(
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockInvestorsRepository: mockInvestorsRepository,
          mockReportRepository: mockReportRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockUrlRepository: mockUrlRepository,
          tester: tester,
        );

        await reportDialogCheckFailureHelper(tester);
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
      //   when(mockAuthenticationRepository.isAnonymouslyOrEmty()).thenAnswer(
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

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.intial} ', (tester) async {
          await investorsPumpAppHelper(
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockInvestorsRepository: mockInvestorsRepository,
            mockReportRepository: mockReportRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            mockUrlRepository: mockUrlRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await investorsInitialHelper(tester);
        });
        testWidgets('Report Dialog Correct Send', (tester) async {
          await investorsPumpAppHelper(
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockInvestorsRepository: mockInvestorsRepository,
            mockReportRepository: mockReportRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            mockUrlRepository: mockUrlRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await reportDialogCorrectSaveHelper(
            tester,
          );
        });
        group('${KGroupText.goTo} ', () {
          testWidgets('nawbar widget navigation', (tester) async {
            await investorsPumpAppHelper(
              mockAppAuthenticationRepository: mockAppAuthenticationRepository,
              mockInvestorsRepository: mockInvestorsRepository,
              mockReportRepository: mockReportRepository,
              mockAuthenticationRepository: mockAuthenticationRepository,
              mockUrlRepository: mockUrlRepository,
              tester: tester,
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
              reportIdItems: KTestText.reportItems.getIdCard,
            ),
          ).thenAnswer(
            (invocation) async => Right(KTestText.fundItems.sublist(0, 2)),
          );
        });
        testWidgets('Tap on scroll button', (tester) async {
          await investorsPumpAppHelper(
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockInvestorsRepository: mockInvestorsRepository,
            mockReportRepository: mockReportRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            mockUrlRepository: mockUrlRepository,
            tester: tester,
          );

          await scaffoldEmptyScrollHelper(tester);
        });
      });
    });
  });
}
