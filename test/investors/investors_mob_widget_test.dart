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
      KTest.testIsWeb = false;

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
        mockInvestorsRepository.getFunds(
          reportIdItems: KTestText.reportItems.getIdCard,
        ),
      ).thenAnswer(
        (invocation) async => Right(KTestText.fundItems),
      );
      when(
        mockUrlRepository.launchUrl(
          url: KTestText.fundItems.first.projectsLink!,
        ),
      ).thenAnswer(
        (invocation) async => const Right(true),
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

    testWidgets('${KGroupText.offlineNetwork} ', (tester) async {
      await networkMobHelper(
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
    });

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
    });
  });
}
