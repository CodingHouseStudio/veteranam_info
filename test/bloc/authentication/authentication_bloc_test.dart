import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

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
            AuthenticationStatus.unauthenticated,
          ),
        );
      },
      expect: () async => [
        const AuthenticationState.unauthenticated(),
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
          const AppLanguageChanged(
            Language.english,
          ),
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
  });
}
