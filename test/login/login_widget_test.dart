import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';
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
        mockAuthenticationRepository.logIn(
          email: KTestText.userEmail,
          password: KTestText.passwordCorrect,
        ),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
      when(
        mockAuthenticationRepository.logIn(
          email: KTestText.useremailWrong,
          password: KTestText.passwordWrong,
        ),
      ).thenAnswer(
        (invocation) async => const Left(SomeFailure.serverError()),
      );
    });

    testWidgets('${KGroupText.intial} ', (tester) async {
      await loginPumpAppHelper(
        mockAuthenticationRepository: mockAuthenticationRepository,
        tester: tester,
      );

      await loginEmployeeInitialHelper(tester);
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

    testWidgets(
        'Write wrong email and password and'
        ' tap submited', (tester) async {
      await loginPumpAppHelper(
        mockAuthenticationRepository: mockAuthenticationRepository,
        tester: tester,
      );

      await wrongSubmitedHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await loginPumpAppHelper(
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await loginEmployeeInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('Navigate to ${KScreenBlocName.signUp}', (tester) async {
          await loginPumpAppHelper(
            mockAuthenticationRepository: mockAuthenticationRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await singUpNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
