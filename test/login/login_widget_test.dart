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
  group('${KScreenBlocName.login} ', () {
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.current = KTestText.feedbackModel.timestamp;
      mockAuthenticationRepository = MockAuthenticationRepository();
      when(
        mockAuthenticationRepository.logIn(
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
          mockAuthenticationRepository.logIn(
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
        await loginPumpAppHelper(
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await wrongSubmitedHelper(tester);
      });
      testWidgets('${KGroupText.failureNetwork} ', (tester) async {
        when(
          mockAuthenticationRepository.logIn(
            email: KTestText.useremailWrong,
            password: KTestText.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => Left(SomeFailure.network(error: null)),
        );
        await loginPumpAppHelper(
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await wrongSubmitedHelper(tester);
      });
      testWidgets('${KGroupText.failureSend} ', (tester) async {
        when(
          mockAuthenticationRepository.logIn(
            email: KTestText.useremailWrong,
            password: KTestText.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => Left(SomeFailure.send(error: null)),
        );
        await loginPumpAppHelper(
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await wrongSubmitedHelper(tester);
      });
      testWidgets('${KGroupText.failure} not found', (tester) async {
        when(
          mockAuthenticationRepository.logIn(
            email: KTestText.useremailWrong,
            password: KTestText.passwordWrong,
          ),
        ).thenAnswer(
          (invocation) async => Left(SomeFailure.notFound(error: null)),
        );
        await loginPumpAppHelper(
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await wrongSubmitedHelper(tester);
      });
    });

    testWidgets('${KGroupText.initial} ', (tester) async {
      await loginPumpAppHelper(
        mockAuthenticationRepository: mockAuthenticationRepository,
        tester: tester,
      );

      await loginInitialHelper(tester);
    });
    testWidgets('Write incorrect email', (tester) async {
      await loginPumpAppHelper(
        mockAuthenticationRepository: mockAuthenticationRepository,
        tester: tester,
      );

      await incorrectEmailHelper(tester);
    });

    testWidgets('Write correct email and hide password', (tester) async {
      await loginPumpAppHelper(
        mockAuthenticationRepository: mockAuthenticationRepository,
        tester: tester,
      );

      await hidePasswordHelper(tester);
    });

    testWidgets(
        'Write correct email and incorect password and'
        ' tap submited', (tester) async {
      await loginPumpAppHelper(
        mockAuthenticationRepository: mockAuthenticationRepository,
        tester: tester,
      );

      await incorrectPasswordHelper(tester);
    });

    testWidgets(
        'Write correct email and password and'
        ' tap submited', (tester) async {
      await loginPumpAppHelper(
        mockAuthenticationRepository: mockAuthenticationRepository,
        tester: tester,
      );

      await submitedHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await loginPumpAppHelper(
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await loginInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('${KRoute.signUp.name} ', (tester) async {
          await loginPumpAppHelper(
            mockAuthenticationRepository: mockAuthenticationRepository,
            tester: tester,
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
            mockAuthenticationRepository: mockAuthenticationRepository,
            tester: tester,
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
