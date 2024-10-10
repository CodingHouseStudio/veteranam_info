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

  group('${KScreenBlocName.pwResetEmail} ', () {
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
      mockAuthenticationRepository = MockAuthenticationRepository();
    });

    group('${KGroupText.failureSend} ', () {
      setUp(() {
        when(
          mockAuthenticationRepository.sendVerificationCodeToEmail(
            email: KTestText.userEmail,
          ),
        ).thenAnswer(
          (invocation) async =>
              Left(SomeFailure.serverError(error: KGroupText.failureSend)),
        );
      });
      testWidgets('Enter correct email', (tester) async {
        await pwResetEmailPumpAppHelper(
          tester: tester,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await emailFailureHelper(tester);
      });
    });

    group('${KGroupText.successful} ', () {
      setUp(() {
        when(
          mockAuthenticationRepository.sendVerificationCodeToEmail(
            email: KTestText.userEmail,
          ),
        ).thenAnswer(
          (invocation) async => const Right(true),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await pwResetEmailPumpAppHelper(
          tester: tester,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await pwResetEmailInitialHelper(tester);
      });

      testWidgets('Enter wrong email', (tester) async {
        await pwResetEmailPumpAppHelper(
          tester: tester,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await emailWrongHelper(tester);
      });

      testWidgets('Enter correct email', (tester) async {
        await pwResetEmailPumpAppHelper(
          tester: tester,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await emailCorrectHelper(tester);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());

        testWidgets('${KGroupText.initial} ', (tester) async {
          await pwResetEmailPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockAuthenticationRepository: mockAuthenticationRepository,
          );

          await pwResetEmailInitialHelper(tester);
        });
      });
    });
  });
}
