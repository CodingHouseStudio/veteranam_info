import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);

  group(
      '${KScreenBlocName.authentication} ${KGroupText.repository} '
      '${KGroupText.stream}', () {
    late AuthenticationRepository authenticationRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late StreamController<User> userStreamController;
    late StreamController<UserSetting> userSettingStreamController;

    setUp(() {
      userStreamController = StreamController<User>()
        ..add(KTestVariables.userAnonymous);
      userSettingStreamController = StreamController<UserSetting>()
        ..add(const UserSetting(id: KTestVariables.field));
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();

      when(mockAppAuthenticationRepository.user).thenAnswer(
        (_) => userStreamController.stream,
      );

      when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
        (_) => const UserSetting(id: KTestVariables.field),
      );

      when(mockAppAuthenticationRepository.userSetting).thenAnswer(
        (_) => userSettingStreamController.stream,
      );

      when(
        mockAppAuthenticationRepository
            .createFcmUserSettingAndRemoveDeletePameter(),
      ).thenAnswer(
        (_) async => const Right(true),
      );

      authenticationRepository = AuthenticationRepository(
        appAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });
    // group('authenticated', () {
    //   setUp(() async {
    //     Timer(
    //       const Duration(milliseconds: 30),
    //       () {
    //         userSettingStreamController = StreamController<UserSetting>()
    //           ..add(const UserSetting(id: KTestText.field));
    //         userStreamController.add(KTestText.user);
    //       },
    //     );
    //   });

    //   test('user ${KGroupText.stream}', () async {
    //     await expectLater(
    //       authenticationRepository.user,
    //       emitsInOrder([
    //         KTestText.userAnonymous,
    //         KTestText.user,
    //       ]),
    //     );
    //   });
    // });
    // group('test anonymously when user change', () {
    //   setUp(() {
    //     userStreamController.add(User.empty);
    //     when(mockAppAuthenticationRepository.isAnonymously).thenAnswer(
    //       (_) => true,
    //     );
    //     when(
    //       mockAppAuthenticationRepository.logInAnonymously(),
    //     ).thenAnswer(
    //       (_) async {
    //         userSettingStreamController = StreamController<UserSetting>()
    //           ..add(UserSetting.empty);
    //         userStreamController.add(KTestText.user.copyWith(email: null));
    //         return const Right(User.empty);
    //       },
    //     );
    //   });

    //   test('user ${KGroupText.stream}', () async {
    //     await expectLater(
    //       authenticationRepository.user,
    //       emitsInOrder([
    //         KTestText.userAnonymous,
    //         User.empty,
    //         KTestText.user.copyWith(email: null),
    //       ]),
    //     );
    //   });
    // });
    // group('anonymously', () {
    //   setUp(() {
    //     when(mockAppAuthenticationRepository.isAnonymously).thenAnswer(
    //       (_) => true,
    //     );
    //   });

    //   test('user ${KGroupText.stream}', () async {
    //     await expectLater(
    //       authenticationRepository.user,
    //       emitsInOrder([
    //         KTestText.userAnonymous,
    //       ]),
    //     );
    //   });
    // });
    // group('user setting', () {
    //   setUp(() {
    //     when(mockAppAuthenticationRepository.isAnonymously).thenAnswer(
    //       (_) => false,
    //     );
    //     when(
    //       mockAppAuthenticationRepository
    //           .createFcmUserSettingAndRemoveDeletePameter(),
    //     ).thenAnswer(
    //       (_) async => const Left(SomeFailure.serverError),
    //     );
    //   });

    //   test('user ${KGroupText.stream}', () async {
    //     await expectLater(
    //       authenticationRepository.userSetting,
    //       emitsInOrder([
    //         const UserSetting(id: KTestText.field),
    //       ]),
    //     );
    //   });
    // });
    group('${KGroupText.failure} log in anonymously', () {
      setUp(() {
        userStreamController.add(User.empty);
        when(mockAppAuthenticationRepository.isAnonymously).thenAnswer(
          (_) => true,
        );
        when(
          mockAppAuthenticationRepository.logInAnonymously(),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
      });

      // test('user ${KGroupText.stream}', () async {
      //   await expectLater(
      //     authenticationRepository.userSetting,
      //     emitsInOrder(
      //       [const UserSetting(id: KTestText.field)],
      //     ),
      //   );
      // });
    });

    tearDown(() async {
      await userStreamController.close();
      await userSettingStreamController.close();
      authenticationRepository.dispose();
    });
  });
}
