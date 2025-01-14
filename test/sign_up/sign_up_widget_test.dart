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
  group('${KScreenBlocName.signUp} ', () {
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.current = KTestVariables.feedbackModel.timestamp;
      mockAuthenticationRepository = MockAuthenticationRepository();
      when(
        mockAuthenticationRepository.signUp(
          email: KTestVariables.userEmail,
          password: KTestVariables.passwordCorrect,
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
            email: KTestVariables.useremailWrong,
            password: KTestVariables.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.serverError),
        );
        await signUpPumpAppHelper(
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await wrongSubmitedHelper(tester);
      });
      testWidgets('${KGroupText.failureNetwork} ', (tester) async {
        when(
          mockAuthenticationRepository.signUp(
            email: KTestVariables.useremailWrong,
            password: KTestVariables.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.network),
        );
        await signUpPumpAppHelper(
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await wrongSubmitedHelper(tester);
      });
      testWidgets('${KGroupText.failureSend} ', (tester) async {
        when(
          mockAuthenticationRepository.signUp(
            email: KTestVariables.useremailWrong,
            password: KTestVariables.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.send),
        );
        await signUpPumpAppHelper(
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await wrongSubmitedHelper(tester);
      });
      testWidgets('${KGroupText.failure} dublicate', (tester) async {
        when(
          mockAuthenticationRepository.signUp(
            email: KTestVariables.useremailWrong,
            password: KTestVariables.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.userDuplicate),
        );
        await signUpPumpAppHelper(
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await wrongSubmitedHelper(tester);
      });
    });

    testWidgets('${KGroupText.initial} ', (tester) async {
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
      testWidgets('${KGroupText.initial} ', (tester) async {
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
