import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  group('${KScreenBlocName.authentication} ${KGroupText.repository} Stream',
      () {
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

      authenticationRepository =
          AuthenticationRepository(mockAppAuthenticationRepository);

      when(mockAppAuthenticationRepository.user).thenAnswer(
        (_) => userStreamController.stream,
      );

      when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
        (_) => const UserSetting(id: KTestText.field),
      );

      when(mockAppAuthenticationRepository.userSetting).thenAnswer(
        (_) => userSettingStreamController.stream,
      );
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
            userStreamController.add(KTestText.user.copyWith(email: null));
            return const Right(true);
          },
        );
      });

      test('user stream', () async {
        final authenticationStatus =
            await authenticationRepository.status.first;

        expect(authenticationStatus, AuthenticationStatus.anonymous);
      });
    });
    group('anonymously', () {
      setUp(() {
        when(mockAppAuthenticationRepository.isAnonymously()).thenAnswer(
          (_) => true,
        );
      });

      test('user stream', () async {
        final authenticationStatus =
            await authenticationRepository.status.first;

        expect(authenticationStatus, AuthenticationStatus.anonymous);
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

      test('user stream', () async {
        final authenticationStatus =
            await authenticationRepository.status.first;

        expect(authenticationStatus, AuthenticationStatus.authenticated);
      });
    });
    group('user setting', () {
      setUp(() {
        when(mockAppAuthenticationRepository.isAnonymously()).thenAnswer(
          (_) => false,
        );
      });

      test('user stream', () async {
        final userSetting = await authenticationRepository.userSetting.first;

        expect(userSetting, const UserSetting(id: KTestText.field));
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
          (_) async => const Left(SomeFailure.serverError()),
        );
      });

      test('user stream', () async {
        final authenticationStatus =
            await authenticationRepository.status.first;

        expect(authenticationStatus, AuthenticationStatus.anonymous);
      });
    });

    tearDown(() async {
      await userStreamController.close();
      await userSettingStreamController.close();
    });
  });
}
