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
    setUp(
      () {
        mockAuthenticationRepository = MockAuthenticationRepository();
        when(
          mockAuthenticationRepository.sendVerificationCodeToEmail(
            email: KTestText.userEmail,
          ),
        ).thenAnswer(
          (invocation) async => const Right(true),
        );
      },
    );

    testWidgets('${KGroupText.initial} ', (tester) async {
      await pwResetEmailPumpAppHelper(
        tester: tester,
        mockAuthenticationRepository: mockAuthenticationRepository,
      );

      await pwResetEmailInitialHelper(tester);
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
}
