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

  group('${KScreenBlocName.passwordReset} ', () {
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      when(
        mockAppAuthenticationRepository.resetPasswordUseCode(
          code: KTestVariables.code,
          newPassword: KTestVariables.passwordCorrect,
        ),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
    });
    group('Code is NULL', () {
      setUp(() {
        when(
          mockAppAuthenticationRepository.checkVerificationCode(
            null,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.serverError),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await passwordResetPumpAppHelper(
          tester: tester,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          code: null,
        );

        await passwordResetWrongCodeHelper(tester);
      });
      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());

        testWidgets('${KGroupText.initial} ', (tester) async {
          await passwordResetPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            code: null,
          );

          await passwordResetWrongCodeHelper(tester);
        });
        group('${KGroupText.goTo} ${KRoute.forgotPassword.name}', () {
          testWidgets('${KGroupText.initial} ', (tester) async {
            await passwordResetPumpAppHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
              mockAppAuthenticationRepository: mockAppAuthenticationRepository,
              code: null,
            );

            await wrongCodeNavigationHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });
        });
      });
    });
    group('Code correct', () {
      setUp(() {
        when(
          mockAppAuthenticationRepository.checkVerificationCode(
            KTestVariables.code,
          ),
        ).thenAnswer(
          (invocation) async => const Right(true),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await passwordResetPumpAppHelper(
          tester: tester,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        );

        await passwordResetInitialHelper(tester);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());

        testWidgets('${KGroupText.initial} ', (tester) async {
          await passwordResetPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          );

          await passwordResetInitialHelper(tester);
        });

        testWidgets('Enter wrong password', (tester) async {
          await passwordResetPumpAppHelper(
            tester: tester,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockGoRouter: mockGoRouter,
          );

          await passwordWrongHelper(tester: tester, mockGoRouter: mockGoRouter);
        });

        testWidgets('Enter correct password', (tester) async {
          await passwordResetPumpAppHelper(
            tester: tester,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockGoRouter: mockGoRouter,
          );

          await passwordCorrectHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        group('${KGroupText.failureSend} ', () {
          setUp(() {
            when(
              mockAppAuthenticationRepository.resetPasswordUseCode(
                code: KTestVariables.code,
                newPassword: KTestVariables.passwordCorrect,
              ),
            ).thenAnswer(
              (invocation) async => const Left(SomeFailure.serverError),
            );
          });
          testWidgets('Enter correct password', (tester) async {
            await passwordResetPumpAppHelper(
              tester: tester,
              mockAppAuthenticationRepository: mockAppAuthenticationRepository,
              mockGoRouter: mockGoRouter,
            );

            await passwordFailureHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });
        });
      });
    });
  });
}
