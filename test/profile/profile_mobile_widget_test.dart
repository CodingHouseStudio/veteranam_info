import 'dart:async';
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
  group('${KScreenBlocName.profile} ', () {
    late UserRepository mockUserRepository;
    late IDataPickerRepository mockDataPickerRepository;
    late AuthenticationRepository mockAuthenticationRepository;
    late StreamController<User> profileStream;
    // late XFile image;
    setUp(() {
      Config.testIsWeb = false;

      mockUserRepository = MockUserRepository();
      mockDataPickerRepository = MockIDataPickerRepository();
      mockAuthenticationRepository = MockAuthenticationRepository();
      profileStream = StreamController()..add(KTestVariables.pureUser);

      when(mockUserRepository.currentUser).thenAnswer(
        (realInvocation) => KTestVariables.userWithoutPhoto,
      );
      when(mockUserRepository.currentUserSetting).thenAnswer(
        (realInvocation) => KTestVariables.userSettingModel,
      );
      when(mockUserRepository.user).thenAnswer(
        (realInvocation) => profileStream.stream,
      );
      when(
        mockUserRepository.updateUserData(
          nickname: KTestVariables.nicknameCorrect,
          image: KTestVariables.filePickerItem,
          user: KTestVariables.profileUserWithoutPhoto,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );

      when(
        mockDataPickerRepository.getImage,
      ).thenAnswer(
        (realInvocation) async => KTestVariables.filePickerItem,
      );

      when(mockAuthenticationRepository.status).thenAnswer(
        (realInvocation) => Stream.value(AuthenticationStatus.authenticated),
      );
      when(mockAuthenticationRepository.currectAuthenticationStatus).thenAnswer(
        (realInvocation) => AuthenticationStatus.authenticated,
      );
      when(mockAuthenticationRepository.logOut()).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(mockAuthenticationRepository.deleteUser()).thenAnswer(
        (realInvocation) async => const Right(true),
      );
    });
    testWidgets('${KGroupText.initial} ', (tester) async {
      await profilePumpAppHelper(
        tester: tester,
        mockUserRepository: mockUserRepository,
        mockDataPickerRepository: mockDataPickerRepository,
        mockAuthenticationRepository: mockAuthenticationRepository,
      );

      await profileInitialHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockUserRepository: mockUserRepository,
          mockDataPickerRepository: mockDataPickerRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await profileInitialHelper(tester);
      });
    });
  });
}
