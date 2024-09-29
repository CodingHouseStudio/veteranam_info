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
  group('${KScreenBlocName.information} ', () {
    late IInformationRepository mockInformationRepository;
    late AuthenticationRepository mockAuthenticationRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late IReportRepository mockReportRepository;
    setUp(() {
      ExtendedDateTime.current = KTestText.dateTime;
      ExtendedDateTime.id = '';
      KPlatformConstants.isWebDesktop = false;
      mockInformationRepository = MockIInformationRepository();
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
      for (var i = 0; i < 5; i++) {
        when(
          mockInformationRepository.updateLikeCount(
            informationModel: KTestText.informationModelItems.elementAt(i),
            isLiked: true,
          ),
        ).thenAnswer(
          (invocation) async => const Right(true),
        );
        when(
          mockInformationRepository.updateLikeCount(
            informationModel: KTestText.informationModelItems.elementAt(i),
            isLiked: false,
          ),
        ).thenAnswer(
          (invocation) async => const Right(true),
        );
      }
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (invocation) => KTestText.user,
      );
      mockReportRepository = MockIReportRepository();
      when(
        mockReportRepository.getCardReportById(
          cardEnum: CardEnum.information,
          userId: KTestText.user.id,
        ),
      ).thenAnswer(
        (invocation) async => Right(KTestText.reportItems),
      );
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(
          mockInformationRepository.getInformationItems(
              // reportIdItems: KTestText.reportItems.getIdCard,
              ),
        ).thenAnswer(
          (invocation) => Stream.error(Exception(KGroupText.failureGet)),
        );
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
        await informationPumpAppHelper(
          mockInformationRepository: mockInformationRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockReportRepository: mockReportRepository,
        );

        await loadingFailureHelper(
          tester: tester,
          card: KWidgetkeys.screen.information.card,
          buttonMock: KWidgetkeys.screen.information.buttonMock,
        );
      });
    });
    group('${KGroupText.getEmptyList} ', () {
      setUp(() {
        when(
          mockInformationRepository.getInformationItems(
              // reportIdItems: KTestText.reportItems.getIdCard,
              ),
        ).thenAnswer(
          (invocation) => Stream.value([]),
        );

        when(mockInformationRepository.addMockInformationItems()).thenAnswer(
          (invocation) {},
        );
        if (GetIt.I.isRegistered<IInformationRepository>()) {
          GetIt.I.unregister<IInformationRepository>();
        }
        GetIt.I.registerSingleton<IInformationRepository>(
          mockInformationRepository,
        );
      });
      testWidgets('${KGroupText.mockButton} ', (tester) async {
        await informationPumpAppHelper(
          mockInformationRepository: mockInformationRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockReportRepository: mockReportRepository,
          tester: tester,
        );

        await mockButtonHelper(
          tester: tester,
          card: KWidgetkeys.screen.information.card,
          buttonMock: KWidgetkeys.screen.information.buttonMock,
        );
      });
    });
    group('${KGroupText.getList} ', () {
      setUp(() {
        when(
          mockInformationRepository.getInformationItems(
              // reportIdItems: KTestText.reportItems.getIdCard,
              ),
        ).thenAnswer(
          (invocation) => Stream.value(KTestText.informationModelItems),
        );
      });

      testWidgets('${KGroupText.initial} ', (tester) async {
        await informationPumpAppHelper(
          mockInformationRepository: mockInformationRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockReportRepository: mockReportRepository,
          tester: tester,
        );

        await informationInitialHelper(tester);
      });

      loadingList(
        (tester) async => informationPumpAppHelper(
          mockInformationRepository: mockInformationRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockReportRepository: mockReportRepository,
          tester: tester,
        ),
        // lastCard: KWidgetkeys.screen.information.cardLast,
      );

      testWidgets('News list load and filter', (tester) async {
        await informationPumpAppHelper(
          mockInformationRepository: mockInformationRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockReportRepository: mockReportRepository,
          tester: tester,
        );

        await listLoadFilterHelper(tester);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await informationPumpAppHelper(
            mockInformationRepository: mockInformationRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockReportRepository: mockReportRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await informationInitialHelper(tester);
        });
      });
    });
  });
}
