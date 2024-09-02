import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
// ignore: unused_import
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.authentication} ${KGroupText.bloc} ', () {
    late AuthenticationRepository mockAuthenticationRepository;
    late AuthenticationBloc authenticationBloc;
    setUp(() {
      mockAuthenticationRepository = MockAuthenticationRepository();
      when(mockAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => KTestText.user,
      );
      when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => KTestText.userSetting,
      );
      when(
        mockAuthenticationRepository.updateUserSetting(
          userSetting: UserSetting.empty.copyWith(locale: Language.english),
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(
        mockAuthenticationRepository.logOut(),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(
        mockAuthenticationRepository.deleteUser(),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      authenticationBloc = AuthenticationBloc(
        authenticationRepository: mockAuthenticationRepository,
      )..add(AuthenticationInitialized());
    });
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.unauthenticated] when'
      ' AuthenticationStatusChanged',
      build: () => authenticationBloc,
      act: (bloc) async {
        bloc.add(
          const AuthenticationStatusChanged(
            AuthenticationStatus.anonymous,
          ),
        );
      },
      expect: () async => [
        const AuthenticationState.anonymous(
          anonymouslyUser: KTestText.user,
          anonymouslyUserSetting: KTestText.userSetting,
        ),
      ],
    );
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.authenticated] when'
      ' AuthenticationStatusChanged',
      build: () => authenticationBloc,
      act: (bloc) async {
        bloc.add(
          const AuthenticationStatusChanged(
            AuthenticationStatus.authenticated,
          ),
        );
      },
      expect: () async => [
        const AuthenticationState.authenticated(
          currentUser: KTestText.user,
          currentUserSetting: KTestText.userSetting,
        ),
      ],
    );
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState] when'
      ' AuthenticationStatusChanged',
      build: () => authenticationBloc,
      act: (bloc) async {
        bloc.add(
          const AuthenticationStatusChanged(
            AuthenticationStatus.unknown,
          ),
        );
      },
      expect: () async => [
        const AuthenticationState.unknown(),
      ],
    );
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState] when'
      ' AppLanguageChanged',
      build: () => authenticationBloc,
      act: (bloc) async {
        bloc.add(
          const AppLanguageChanged(),
        );
      },
      expect: () async => [
        AuthenticationState.authenticated(
          currentUser: KTestText.user,
          currentUserSetting:
              KTestText.userSetting.copyWith(locale: Language.english),
        ),
      ],
    );
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState] when'
      ' AuthenticationLogoutRequested',
      build: () => authenticationBloc,
      act: (bloc) async {
        bloc.add(
          AuthenticationLogoutRequested(),
        );
      },
      expect: () => <dynamic>[],
    );
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState] when'
      ' AppUserRoleChanged',
      build: () => authenticationBloc,
      act: (bloc) async {
        bloc.add(
          const AppUserRoleChanged(UserRole.civilian),
        );
      },
      expect: () => [
        AuthenticationState.authenticated(
          currentUser: KTestText.user,
          currentUserSetting:
              KTestText.userSetting.copyWith(userRole: UserRole.civilian),
        ),
      ],
    );
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState] when'
      ' AuthenticationDeleteRequested',
      build: () => authenticationBloc,
      act: (bloc) async {
        bloc.add(
          AuthenticationDeleteRequested(),
        );
      },
    );
  });
}
