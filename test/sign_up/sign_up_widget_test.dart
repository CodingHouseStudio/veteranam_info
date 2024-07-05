import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../text_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.signUp} ', () {
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.current = KTestText.feedbackModel.timestamp;
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      when(
        mockAppAuthenticationRepository.signUp(
          email: KTestText.userEmail,
          password: KTestText.passwordCorrect,
        ),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
    });
    group('${KGroupText.failure} ', () {
      testWidgets('${KGroupText.error} ', (tester) async {
        when(
          mockAppAuthenticationRepository.signUp(
            email: KTestText.useremailWrong,
            password: KTestText.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.serverError()),
        );
        await signUpPumpAppHelper(
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          tester: tester,
        );

        await signUpFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureNetwork} ', (tester) async {
        when(
          mockAppAuthenticationRepository.signUp(
            email: KTestText.useremailWrong,
            password: KTestText.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.network()),
        );
        await signUpPumpAppHelper(
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          tester: tester,
        );

        await signUpFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureSend} ', (tester) async {
        when(
          mockAppAuthenticationRepository.signUp(
            email: KTestText.useremailWrong,
            password: KTestText.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.send()),
        );
        await signUpPumpAppHelper(
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          tester: tester,
        );

        await signUpFailureHelper(tester);
      });
      testWidgets('${KGroupText.failure} dublicate', (tester) async {
        when(
          mockAppAuthenticationRepository.signUp(
            email: KTestText.useremailWrong,
            password: KTestText.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.duplicate()),
        );
        await signUpPumpAppHelper(
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          tester: tester,
        );

        await signUpFailureHelper(tester);
      });
    });

    testWidgets('${KGroupText.intial} ', (tester) async {
      await signUpPumpAppHelper(
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        tester: tester,
      );

      await signUpInitialHelper(tester);
    });
    testWidgets('Write incorrect email', (tester) async {
      await signUpPumpAppHelper(
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        tester: tester,
      );

      await incorrectEmailHelper(tester);
    });

    testWidgets('Write correct email and hide password', (tester) async {
      await signUpPumpAppHelper(
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        tester: tester,
      );

      await hidePasswordHelper(tester);
    });
    testWidgets(
        'Write correct email and incorect password and'
        ' tap submited', (tester) async {
      await signUpPumpAppHelper(
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        tester: tester,
      );

      await incorrectPasswordHelper(tester);
    });

    testWidgets(
        'Write correct email and password and'
        ' tap submited', (tester) async {
      await signUpPumpAppHelper(
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        tester: tester,
      );

      await submitedHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await signUpPumpAppHelper(
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await signUpInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('Navigate to ${KScreenBlocName.signUp}', (tester) async {
          await signUpPumpAppHelper(
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
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
