import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.profile} ', () {
    setUp(profileWidgetTestRegister);
    testWidgets('${KGroupText.initial} ', (tester) async {
      await profilePumpAppHelper(
        tester,
      );

      await profileInitialHelper(tester);
    });
    // group('Nickname empty', () {
    //   setUp(() {
    //     when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
    //       (realInvocation) => KTestVariables.userSetting,
    //     );
    //   });
    //   testWidgets('${KGroupText.initial} ', (tester) async {
    //     await profilePumpAppHelper(
    //       tester: tester,
    //       mockAuthenticationRepository: mockAuthenticationRepository,
    //       mockDataPickerRepository: mockDataPickerRepository,
    //     );

    //     await profileInitialHelper(tester);
    //   });
    // });

    testWidgets('Show log out dialog', (tester) async {
      await profilePumpAppHelper(
        tester,
      );

      await profileLogOutHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await profilePumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await profileInitialHelper(tester);
      });

      testWidgets('Log out desk dialog unconfirm button pop', (tester) async {
        await profilePumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );
        await logOutUnconfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          icon: false,
          // deskOpen: true,
        );
      });
      testWidgets('Log out mob dialog cancel icon pop', (tester) async {
        await profilePumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await logOutUnconfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          icon: true,
        );
      });

      testWidgets('Log out dialog confirm button pop', (tester) async {
        await profilePumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await logOutConfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      });

      testWidgets('Delete account desk dialog unconfirm button pop',
          (tester) async {
        await profilePumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await deleteAccountUnconfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          icon: false,
          deskOpen: true,
        );
      });

      testWidgets('Delete account dialog cancel icon pop', (tester) async {
        await profilePumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await deleteAccountUnconfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          icon: true,
        );
      });

      testWidgets('Delete account dialog confirm button pop', (tester) async {
        await profilePumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await deleteAccountConfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      });

      testWidgets('Send correct profile data', (tester) async {
        await profilePumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await profileFormsCorrectSaveHelper(
          tester: tester,
        );
      });

      group('Current user empty ', () {
        setUp(
          () => when(mockUserRepository.currentUser).thenAnswer(
            (realInvocation) => KTestVariables.pureUser,
          ),
        );
        testWidgets('Send incorrect profile data', (tester) async {
          await profilePumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );
          profileStream.add(
            KTestVariables.profileUserWithoutPhoto.copyWith(
              id: 'none',
              email: KTestVariables.userEmail,
              name: null,
            ),
          );

          await profileFormsIncorrectSaveHelper(
            tester: tester,
          );
        });
      });

      // group('${KGroupText.goTo} ', () {
      //   testWidgets('Profile Navigation', (tester) async {
      //     await profilePumpAppHelper(
      //       tester: tester,
      //       mockGoRouter: mockGoRouter,
      //       mockAuthenticationRepository: mockAuthenticationRepository,
      //     );

      //     await profileNavigationHelper(
      //       tester: tester,
      //       mockGoRouter: mockGoRouter,
      //     );
      //   });
      // });

      // group('${Config.business} ', () {
      //     setUp(
      //       () => Config.roleValue = Config.business,
      //     );

      //     testWidgets('${KRoute.myDiscounts.name} ', (tester) async {
      //       await profilePumpAppHelper(
      //         tester: tester,
      //         mockGoRouter: mockGoRouter,
      //         mockAuthenticationRepository: mockAuthenticationRepository,
      //       );

      //       await profileMyDiscountsHelper(
      //         tester: tester,
      //         mockGoRouter: mockGoRouter,
      //       );
      //     });
      //   });
    });
    tearDown(() async => profileStream.close());
  });
}
