// ignore_for_file: unused_import

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

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
        ..add(KTestText.user.copyWith(email: null));
      userSettingStreamController = StreamController<UserSetting>()
        ..add(const UserSetting(id: KTestText.field));
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();

      when(mockAppAuthenticationRepository.user).thenAnswer(
        (_) => userStreamController.stream,
      );

      when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
        (_) => const UserSetting(id: KTestText.field),
      );

      when(mockAppAuthenticationRepository.userSetting).thenAnswer(
        (_) => userSettingStreamController.stream,
      );

      when(mockAppAuthenticationRepository.createFcmUserSetting()).thenAnswer(
        (_) async => const Right(true),
      );

      authenticationRepository =
          AuthenticationRepository(mockAppAuthenticationRepository);
    });

    group('anonymously when user change', () {
      setUp(() {
        userStreamController.add(User.empty);
        when(mockAppAuthenticationRepository.isAnonymously()).thenAnswer(
          (_) => true,
        );
        when(
          mockAppAuthenticationRepository.logInAnonymously(),
        ).thenAnswer(
          (_) async {
            userSettingStreamController = StreamController<UserSetting>()
              ..add(UserSetting.empty);
            userStreamController.add(KTestText.user.copyWith(email: null));
            return const Right(true);
          },
        );
      });

      test('user ${KGroupText.stream}', () async {
        await expectLater(
          authenticationRepository.status,
          emitsInOrder([
            AuthenticationStatus.anonymous,
            AuthenticationStatus.anonymous,
          ]),
        );
      });
    });
    group('anonymously', () {
      setUp(() {
        when(mockAppAuthenticationRepository.isAnonymously()).thenAnswer(
          (_) => true,
        );
      });

      test('user ${KGroupText.stream}', () async {
        await expectLater(
          authenticationRepository.status,
          emitsInOrder([
            AuthenticationStatus.anonymous,
          ]),
        );
      });
    });
    group('authenticated', () {
      setUp(() {
        userStreamController.add(KTestText.user);
        late var value = true;
        when(mockAppAuthenticationRepository.isAnonymously()).thenAnswer(
          (_) {
            if (value) {
              userSettingStreamController = StreamController<UserSetting>()
                ..add(UserSetting.empty);
              value = false;
            }
            return false;
          },
        );
      });

      test('user ${KGroupText.stream}', () async {
        await expectLater(
          authenticationRepository.status,
          emitsInOrder([
            AuthenticationStatus.authenticated,
            AuthenticationStatus.authenticated,
          ]),
        );
      });
    });
    group('user setting', () {
      setUp(() {
        when(mockAppAuthenticationRepository.isAnonymously()).thenAnswer(
          (_) => false,
        );
        when(mockAppAuthenticationRepository.createFcmUserSetting()).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
      });

      test('user ${KGroupText.stream}', () async {
        await expectLater(
          authenticationRepository.userSetting,
          emitsInOrder([
            const UserSetting(id: KTestText.field),
          ]),
        );
      });
    });
    group('${KGroupText.failure} log in anonymously', () {
      setUp(() {
        userStreamController.add(User.empty);
        when(mockAppAuthenticationRepository.isAnonymously()).thenAnswer(
          (_) => true,
        );
        when(
          mockAppAuthenticationRepository.logInAnonymously(),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
      });

      test('user ${KGroupText.stream}', () async {
        await expectLater(
          authenticationRepository.status,
          emitsInOrder(
            [AuthenticationStatus.anonymous],
          ),
        );
      });
    });

    tearDown(() async {
      await userStreamController.close();
      await userSettingStreamController.close();
    });
  });
}
