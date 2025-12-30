import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/shared/shared_dart.dart';
import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.login} ', () {
    setUp(loginTestWidgetRegister);
    group('${KGroupText.failure} ', () {
      testWidgets('${KGroupText.error} ', (tester) async {
        when(
          mockAppAuthenticationRepository.logIn(
            email: KTestVariables.useremailWrong,
            password: KTestVariables.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.serverError),
        );
        await loginPumpAppHelper(
          tester,
        );

        await wrongSubmitedHelper(tester);
      });
      testWidgets('${KGroupText.failureNetwork} ', (tester) async {
        when(
          mockAppAuthenticationRepository.logIn(
            email: KTestVariables.useremailWrong,
            password: KTestVariables.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.network),
        );
        await loginPumpAppHelper(
          tester,
        );

        await wrongSubmitedHelper(tester);
      });
      testWidgets('${KGroupText.failureSend} ', (tester) async {
        when(
          mockAppAuthenticationRepository.logIn(
            email: KTestVariables.useremailWrong,
            password: KTestVariables.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.send),
        );
        await loginPumpAppHelper(
          tester,
        );

        await wrongSubmitedHelper(tester);
      });
      testWidgets('${KGroupText.failure} not found', (tester) async {
        when(
          mockAppAuthenticationRepository.logIn(
            email: KTestVariables.useremailWrong,
            password: KTestVariables.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.dataNotFound),
        );
        await loginPumpAppHelper(
          tester,
        );

        await wrongSubmitedHelper(tester);
      });
    });

    testWidgets('${KGroupText.initial} ', (tester) async {
      await loginPumpAppHelper(
        tester,
      );

      await loginInitialHelper(tester);
    });
    testWidgets('Write incorrect email', (tester) async {
      await loginPumpAppHelper(
        tester,
      );

      await incorrectEmailHelper(tester);
    });

    testWidgets('Write correct email and hide password', (tester) async {
      await loginPumpAppHelper(
        tester,
      );

      await hidePasswordHelper(tester);
    });

    testWidgets(
        'Write correct email and incorect password and'
        ' tap submited', (tester) async {
      await loginPumpAppHelper(
        tester,
      );

      await incorrectPasswordHelper(tester);
    });

    testWidgets(
        'Write correct email and password and'
        ' tap submited', (tester) async {
      await loginPumpAppHelper(
        tester,
      );

      await submitedHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await loginPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await loginInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('${KRoute.signUp.name} ', (tester) async {
          await loginPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await loginNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
        testWidgets('${KRoute.forgotPassword.name} ', (tester) async {
          Config.roleValue = Config.business;
          await loginPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await loginFormNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
