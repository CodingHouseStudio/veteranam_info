import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/data_provider/firebase_anaytics_cache_controller.dart';
import 'package:veteranam/shared/data_provider/shared_preferences_provider.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.userRole} ', () {
    setUp(_cookiesHideDialog);
    testWidgets('${KGroupText.initial} ', (tester) async {
      await userRolePumpAppHelper(
        tester: tester,
      );

      await userRoleInitialHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() {
        mockGoRouter = MockGoRouter();
        _cookiesHideDialog();
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await userRolePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await userRoleInitialHelper(tester);
      });
      // testWidgets('Drop down buttons intial', (tester) async {
      //   await userRolePumpAppHelper(
      //     tester: tester,
      //     mockGoRouter: mockGoRouter,
      //   );

      //   await dropDownScrollHelper(
      //     test: () async => userRoleLoginButtonHelper(
      //       tester: tester,
      //     ),
      //     tester: tester,
      //   );
      // });
      // TODO(test): Add unit tests
      group('Show Cookies Dialog', () {
        setUp(() {
          final SharedPrefencesProvider mockSharedPrefencesProvider =
              MockSharedPrefencesProvider();
          final firebaseAnalyticsCacheController =
              FirebaseAnalyticsCacheController(
            sharedPrefencesProvider: mockSharedPrefencesProvider,
          );

          when(
            firebaseAnalyticsCacheController.consentDialogShowed,
          ).thenAnswer(
            (realInvocation) => false,
          );

          if (GetIt.I.isRegistered<FirebaseAnalyticsCacheController>()) {
            GetIt.I.unregister<FirebaseAnalyticsCacheController>();
          }
          GetIt.I.registerSingleton<FirebaseAnalyticsCacheController>(
            firebaseAnalyticsCacheController,
          );
        });
        testWidgets('Cookies dialog accept', (tester) async {
          await userRolePumpAppHelper(
            tester: tester,
          );

          await cookiesAcceptDialogHelper(tester);
        });

        testWidgets('Cookies dialog accept necessary', (tester) async {
          await userRolePumpAppHelper(
            tester: tester,
          );

          await changeWindowSizeHelper(
            tester: tester,
            test: () async => cookiesAcceptNecessaryDialogHelper(tester),
          );
        });

        testWidgets('Cookies dialog tap privact policy text', (tester) async {
          await userRolePumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await privacyPolicyCookiesDialogHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });

      group('${KGroupText.goTo} ', () {
        testWidgets('Sign Up business button ', (tester) async {
          await userRolePumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await signUpButtonsNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
        testWidgets('Drop down button for user login', (tester) async {
          await userRolePumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await dropDownLoginUserNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
        testWidgets('Drop down button for business login', (tester) async {
          await userRolePumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await dropDownLoginBusinessNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}

void _cookiesHideDialog() {
  final SharedPrefencesProvider mockSharedPrefencesProvider =
      MockSharedPrefencesProvider();
  final firebaseAnalyticsCacheController = FirebaseAnalyticsCacheController(
    sharedPrefencesProvider: mockSharedPrefencesProvider,
  );

  when(
    firebaseAnalyticsCacheController.consentDialogShowed,
  ).thenAnswer(
    (realInvocation) => true,
  );

  if (GetIt.I.isRegistered<FirebaseAnalyticsCacheController>()) {
    GetIt.I.unregister<FirebaseAnalyticsCacheController>();
  }
  GetIt.I.registerSingleton<FirebaseAnalyticsCacheController>(
    firebaseAnalyticsCacheController,
  );
}
