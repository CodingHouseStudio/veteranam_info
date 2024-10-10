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

  group('${KScreenBlocName.passwordReset} ', () {
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
      mockAuthenticationRepository = MockAuthenticationRepository();
      when(
        mockAuthenticationRepository.resetPasswordUseCode(
          code: KTestText.code,
          newPassword: KTestText.passwordCorrect,
        ),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
    });
    group('Code is NULL', () {
      setUp(() {
        when(
          mockAuthenticationRepository.checkVerificationCode(
            null,
          ),
        ).thenAnswer(
          (invocation) async =>
              Left(SomeFailure.serverError(error: KGroupText.failure)),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await passwordResetPumpAppHelper(
          tester: tester,
          mockAuthenticationRepository: mockAuthenticationRepository,
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
            mockAuthenticationRepository: mockAuthenticationRepository,
            code: null,
          );

          await passwordResetWrongCodeHelper(tester);
        });
        group('${KGroupText.goTo} ${KRoute.pwResetEmail.name}', () {
          testWidgets('${KGroupText.initial} ', (tester) async {
            await passwordResetPumpAppHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
              mockAuthenticationRepository: mockAuthenticationRepository,
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
          mockAuthenticationRepository.checkVerificationCode(
            KTestText.code,
          ),
        ).thenAnswer(
          (invocation) async => const Right(true),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await passwordResetPumpAppHelper(
          tester: tester,
          mockAuthenticationRepository: mockAuthenticationRepository,
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
            mockAuthenticationRepository: mockAuthenticationRepository,
          );

          await passwordResetInitialHelper(tester);
        });

        testWidgets('Enter wrong password', (tester) async {
          await passwordResetPumpAppHelper(
            tester: tester,
            mockAuthenticationRepository: mockAuthenticationRepository,
            mockGoRouter: mockGoRouter,
          );

          await passwordWrongHelper(tester: tester, mockGoRouter: mockGoRouter);
        });

        testWidgets('Enter correct password', (tester) async {
          await passwordResetPumpAppHelper(
            tester: tester,
            mockAuthenticationRepository: mockAuthenticationRepository,
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
              mockAuthenticationRepository.resetPasswordUseCode(
                code: KTestText.code,
                newPassword: KTestText.passwordCorrect,
              ),
            ).thenAnswer(
              (invocation) async =>
                  Left(SomeFailure.serverError(error: KGroupText.failureSend)),
            );
          });
          testWidgets('Enter correct password', (tester) async {
            await passwordResetPumpAppHelper(
              tester: tester,
              mockAuthenticationRepository: mockAuthenticationRepository,
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
