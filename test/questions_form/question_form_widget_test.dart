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
    late UserRepository mockUserRepository;
    setUp(() {
      mockUserRepository = MockUserRepository();
      when(mockUserRepository.currentUser).thenAnswer(
        (realInvocation) => KTestVariables.userWithoutPhoto,
      );
      when(mockUserRepository.currentUserSetting).thenAnswer(
        (realInvocation) => UserSetting.empty,
      );
      when(
        mockUserRepository.updateUserSetting(
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
        mockUserRepository: mockUserRepository,
      );

      await questionForminitialHelper(tester);
    });
    testWidgets('check point switch', (tester) async {
      await questionFormPumpAppHelper(
        tester: tester,
        mockUserRepository: mockUserRepository,
      );

      await checkPointHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await questionFormPumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockUserRepository: mockUserRepository,
        );

        await questionForminitialHelper(tester);
      });
      testWidgets('send user role', (tester) async {
        await questionFormPumpAppHelper(
          tester: tester,
          mockUserRepository: mockUserRepository,
          mockGoRouter: mockGoRouter,
        );

        await sendUserRoleHelper(
          tester: tester,
          mockUserRepository: mockUserRepository,
        );
      });
    });
  });
}
