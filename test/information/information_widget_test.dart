import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.information} ', () {
    late IInformationRepository mockInformationRepository;
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
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
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        ExtendedDateTime.current = KTestText.dateTime;
        ExtendedDateTime.id = '';
        when(mockInformationRepository.getInformationItems()).thenAnswer(
          (invocation) => Stream.error(Exception(KGroupText.failureGet)),
        );
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
        await informationPumpAppHelper(
          mockInformationRepository: mockInformationRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
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
        when(mockInformationRepository.getInformationItems()).thenAnswer(
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
        when(mockInformationRepository.getInformationItems()).thenAnswer(
          (invocation) => Stream.value(KTestText.informationModelItems),
        );
      });

      testWidgets('${KGroupText.intial} ', (tester) async {
        await informationPumpAppHelper(
          mockInformationRepository: mockInformationRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await informationInitialHelper(tester);
      });

      loadingList(
        pumpApp: (tester) async => informationPumpAppHelper(
          mockInformationRepository: mockInformationRepository,
          tester: tester,
        ),
        lastCard: KWidgetkeys.screen.information.cardLast,
      );

      testWidgets('News list load and filter', (tester) async {
        KPlatformConstants.isWebDesktop = false;
        await informationPumpAppHelper(
          mockInformationRepository: mockInformationRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await listLoadFilterHelper(tester);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.intial} ', (tester) async {
          await informationPumpAppHelper(
            mockInformationRepository: mockInformationRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await informationInitialHelper(tester);
        });

        group('${KGroupText.goTo} ', () {
          testWidgets('nawbar widget navigation', (tester) async {
            await informationPumpAppHelper(
              mockInformationRepository: mockInformationRepository,
              mockAuthenticationRepository: mockAuthenticationRepository,
              tester: tester,
              mockGoRouter: mockGoRouter,
            );

            await navbarNavigationHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });
        });
      });
    });
  });
}
