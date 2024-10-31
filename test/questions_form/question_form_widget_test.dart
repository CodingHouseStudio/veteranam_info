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
  group('${KScreenBlocName.questionsForm} ', () {
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
      mockAuthenticationRepository = MockAuthenticationRepository();
      when(mockAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => KTestText.userWithoutPhoto,
      );
      when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => UserSetting.empty,
      );
      when(
        mockAuthenticationRepository.updateUserSetting(
          userSetting: UserSetting.empty.copyWith(
            userRole: UserRole.veteran,
          ),
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
    });
    testWidgets('${KGroupText.initial} ', (tester) async {
      await questionFormPumpAppHelper(
        tester: tester,
        mockAuthenticationRepository: mockAuthenticationRepository,
      );

      await questionForminitialHelper(tester);
    });
    testWidgets('check point switch', (tester) async {
      await questionFormPumpAppHelper(
        tester: tester,
        mockAuthenticationRepository: mockAuthenticationRepository,
      );

      await checkPointHelper(tester);
    });
    testWidgets('send user role', (tester) async {
      await questionFormPumpAppHelper(
        tester: tester,
        mockAuthenticationRepository: mockAuthenticationRepository,
      );

      await sendUserRoleHelper(
        tester: tester,
        mockAuthenticationRepository: mockAuthenticationRepository,
      );
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await questionFormPumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await questionForminitialHelper(tester);
      });
    });
  });
}
