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
  group('${KScreenBlocName.profile} ', () {
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
      mockAuthenticationRepository = MockAuthenticationRepository();
      // mockAppAuthenticationRepository = MockAppAuthenticationRepository();

      when(mockAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => KTestText.userWithoutPhoto,
      );
      when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => UserSetting.empty,
      );
      when(mockAuthenticationRepository.isAnonymouslyOrEmty()).thenAnswer(
        (realInvocation) => false,
      );
    });
    testWidgets('${KGroupText.intial} ', (tester) async {
      await profilePumpAppHelper(
        tester: tester,
        mockAuthenticationRepository: mockAuthenticationRepository,
      );

      await profileInitialHelper(tester);
    });
    testWidgets('Show log out dialog', (tester) async {
      await profilePumpAppHelper(
        tester: tester,
        mockAuthenticationRepository: mockAuthenticationRepository,
      );

      await profileCardLogOutHelper(tester);
    });

    testWidgets('Show delete account dialog', (tester) async {
      await profilePumpAppHelper(
        tester: tester,
        mockAuthenticationRepository: mockAuthenticationRepository,
      );

      await profileCardDeleteAccountHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await profileInitialHelper(tester);
      });

      testWidgets('Log out dialog unconfirm button pop', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await changeWindowSizeHelper(
          tester: tester,
          test: () async => logOutUnconfirmButtonlHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          ),
        );
      });

      testWidgets('Log out dialog confirm button pop', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await logOutConfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      });

      testWidgets('Delete account dialog unconfirm button pop', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await changeWindowSizeHelper(
          tester: tester,
          test: () async => deleteAccountUnconfirmButtonlHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          ),
        );
      });

      testWidgets('Delete account dialog confirm button pop', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await deleteAccountConfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      });

      group('${KGroupText.goTo} ', () {
        testWidgets('Profile Navigation', (tester) async {
          await profilePumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockAuthenticationRepository: mockAuthenticationRepository,
          );

          await profileNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
