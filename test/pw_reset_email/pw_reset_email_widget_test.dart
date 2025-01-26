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

  group('${KScreenBlocName.pwResetEmail} ', () {
    setUp(pwResetEmailTestWidgetRegister);

    group('${KGroupText.failureSend} ', () {
      setUp(() {
        when(
          mockAppAuthenticationRepository.sendVerificationCode(
            email: KTestVariables.userEmail,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.serverError),
        );
      });
      testWidgets('Enter correct email', (tester) async {
        await pwResetEmailPumpAppHelper(
          tester,
        );

        await emailFailureHelper(tester);
      });
    });

    group('${KGroupText.successful} ', () {
      setUp(() {
        when(
          mockAppAuthenticationRepository.sendVerificationCode(
            email: KTestVariables.userEmail,
          ),
        ).thenAnswer(
          (invocation) async => const Right(true),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await pwResetEmailPumpAppHelper(
          tester,
        );

        await pwResetEmailInitialHelper(tester);
      });

      testWidgets('Enter wrong email', (tester) async {
        await pwResetEmailPumpAppHelper(
          tester,
        );

        await emailWrongHelper(tester);
      });

      testWidgets('Enter correct email', (tester) async {
        await pwResetEmailPumpAppHelper(
          tester,
        );

        await emailCorrectHelper(tester);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());

        testWidgets('${KGroupText.initial} ', (tester) async {
          await pwResetEmailPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await pwResetEmailInitialHelper(tester);
        });
        testWidgets('Back button ', (tester) async {
          await pwResetEmailPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await backButtonResetEmailNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
