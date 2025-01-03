import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

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
    late UserRepository mockUserRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late IUrlRepository mockUrlRepository;
    setUp(() {
      ExtendedDateTime.current = KTestVariables.dateTime;
      ExtendedDateTime.id = '';
      Config.testIsWeb = false;

      mockInvestorsRepository = MockIInvestorsRepository();
      mockReportRepository = MockIReportRepository();
      mockUserRepository = MockUserRepository();
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      mockUrlRepository = MockIUrlRepository();

      when(mockUserRepository.currentUser).thenAnswer(
        (realInvocation) => User.empty,
      );
      when(mockUserRepository.currentUserSetting).thenAnswer(
        (realInvocation) => UserSetting.empty,
      );
      // when(mockUserRepository.isAnonymously).thenAnswer(
      //   (realInvocation) => true,
      // );
      when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => UserSetting.empty,
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => KTestVariables.user,
      );
      when(mockAppAuthenticationRepository.isAnonymously).thenAnswer(
        (realInvocation) => true,
      );
      when(
        mockReportRepository.sendReport(
          KTestVariables.reportModel
              .copyWith(reasonComplaint: ReasonComplaint.other),
        ),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
      when(
        mockReportRepository.getCardReportById(
          cardEnum: CardEnum.funds,
          userId: KTestVariables.user.id,
        ),
      ).thenAnswer(
        (invocation) async => Right(KTestVariables.reportItems),
      );
      when(
        mockInvestorsRepository.getFunds(
            // reportIdItems: KTestText.reportItems.getIdCard,
            ),
      ).thenAnswer(
        (invocation) async => Right(KTestVariables.fundItems),
      );
      when(
        mockUrlRepository.launchUrl(
          url: KTestVariables.fundItems.first.projectsLink!,
        ),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
    });

    testWidgets('${KGroupText.initial} ', (tester) async {
      await investorsPumpAppHelper(
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        mockInvestorsRepository: mockInvestorsRepository,
        mockReportRepository: mockReportRepository,
        mockUserRepository: mockUserRepository,
        mockUrlRepository: mockUrlRepository,
        tester: tester,
      );

      await investorsInitialHelper(tester);
    });

    // testWidgets('${KGroupText.offlineNetwork} ', (tester) async {
    //   await networkMobHelper(
    //     tester: tester,
    //     pumpApp: () async => investorsPumpAppHelper(
    //       mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    //       mockInvestorsRepository: mockInvestorsRepository,
    //       mockReportRepository: mockReportRepository,
    //       mockAuthenticationRepository: mockAuthenticationRepository,
    //       mockUrlRepository: mockUrlRepository,
    //       tester: tester,
    //     ),
    //   );
    // });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await investorsPumpAppHelper(
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockInvestorsRepository: mockInvestorsRepository,
          mockReportRepository: mockReportRepository,
          mockUserRepository: mockUserRepository,
          mockUrlRepository: mockUrlRepository,
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await investorsInitialHelper(tester);
      });
    });
  });
}
