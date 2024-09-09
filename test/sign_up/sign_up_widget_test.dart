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
  group('${KScreenBlocName.signUp} ', () {
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.current = KTestText.feedbackModel.timestamp;
      mockAuthenticationRepository = MockAuthenticationRepository();
      when(
        mockAuthenticationRepository.signUp(
          email: KTestText.userEmail,
          password: KTestText.passwordCorrect,
        ),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
      when(
        mockAuthenticationRepository.signUpWithGoogle(),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );

      when(
        mockAuthenticationRepository.signUpWithFacebook(),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
    });
    group('${KGroupText.failure} ', () {
      testWidgets('${KGroupText.error} ', (tester) async {
        when(
          mockAuthenticationRepository.signUp(
            email: KTestText.useremailWrong,
            password: KTestText.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => Left(
            SomeFailure.serverError(
              error: null,
            ),
          ),
        );
        await signUpPumpAppHelper(
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await signUpFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureNetwork} ', (tester) async {
        when(
          mockAuthenticationRepository.signUp(
            email: KTestText.useremailWrong,
            password: KTestText.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => Left(SomeFailure.network(error: null)),
        );
        await signUpPumpAppHelper(
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await signUpFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureSend} ', (tester) async {
        when(
          mockAuthenticationRepository.signUp(
            email: KTestText.useremailWrong,
            password: KTestText.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => Left(SomeFailure.send(error: null)),
        );
        await signUpPumpAppHelper(
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await signUpFailureHelper(tester);
      });
      testWidgets('${KGroupText.failure} dublicate', (tester) async {
        when(
          mockAuthenticationRepository.signUp(
            email: KTestText.useremailWrong,
            password: KTestText.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => Left(SomeFailure.duplicate(error: null)),
        );
        await signUpPumpAppHelper(
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await signUpFailureHelper(tester);
      });
    });

    testWidgets('${KGroupText.intial} ', (tester) async {
      await signUpPumpAppHelper(
        mockAuthenticationRepository: mockAuthenticationRepository,
        tester: tester,
      );

      await signUpInitialHelper(tester);
    });
    testWidgets('Write incorrect email', (tester) async {
      await signUpPumpAppHelper(
        mockAuthenticationRepository: mockAuthenticationRepository,
        tester: tester,
      );

      await incorrectEmailHelper(tester);
    });

    testWidgets('Write correct email and hide password', (tester) async {
      await signUpPumpAppHelper(
        mockAuthenticationRepository: mockAuthenticationRepository,
        tester: tester,
      );

      await hidePasswordHelper(tester);
    });
    testWidgets(
        'Write correct email and incorect password and'
        ' tap submited', (tester) async {
      await signUpPumpAppHelper(
        mockAuthenticationRepository: mockAuthenticationRepository,
        tester: tester,
      );

      await incorrectPasswordHelper(tester);
    });

    testWidgets(
        'Write correct email and password and'
        ' tap submited', (tester) async {
      await signUpPumpAppHelper(
        mockAuthenticationRepository: mockAuthenticationRepository,
        tester: tester,
      );

      await submitedHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await signUpPumpAppHelper(
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await signUpInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('Navigate to ${KScreenBlocName.signUp}', (tester) async {
          await signUpPumpAppHelper(
            mockAuthenticationRepository: mockAuthenticationRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await signUpNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
