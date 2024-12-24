// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
// import 'package:mockito/mockito.dart';
// import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);

  // group('${KScreenBlocName.authentication} ${KGroupText.bloc} ', () {
  //   late AuthenticationRepository mockAuthenticationRepository;
  // late AuthenticationBloc authenticationBloc;
  // setUp(() {
  //   mockAuthenticationRepository = MockAuthenticationRepository();
  //   // when(mockAuthenticationRepository.currentUser).thenAnswer(
  //   //   (realInvocation) => KTestText.user,
  //   // );
  //   // when(mockAuthenticationRepository.user).thenAnswer(
  //   //   (realInvocation) => Stream.value(KTestText.user),
  //   // );
  //   // when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
  //   //   (realInvocation) => KTestText.userSetting,
  //   // );
  //   // when(
  //   //   mockAuthenticationRepository.updateUserSetting(
  //   //     userSetting: UserSetting.empty.copyWith(locale: Language.english),
  //   //   ),
  //   // ).thenAnswer(
  //   //   (realInvocation) async => const Right(true),
  //   // );
  //   when(
  //     mockAuthenticationRepository.logOut(),
  //   ).thenAnswer(
  //     (realInvocation) async => const Right(true),
  //   );
  //   when(
  //     mockAuthenticationRepository.deleteUser(),
  //   ).thenAnswer(
  //     (realInvocation) async => const Right(true),
  //   );
  //   // authenticationBloc = AuthenticationBloc(
  //   //   authenticationRepository: mockAuthenticationRepository,
  //   // );
  // });
  // blocTest<AuthenticationBloc, AuthenticationState>(
  //   'emits [AuthenticationState.anonymous] when'
  //   ' AuthenticationInitialized',
  //   build: () => authenticationBloc,
  //   act: (bloc) async {
  //     when(mockAuthenticationRepository.isAnonymously).thenAnswer(
  //       (realInvocation) => true,
  //     );
  //     bloc.add(
  //       AuthenticationInitialized(),
  //     );
  //   },
  //   expect: () async => [
  //     const AuthenticationState.anonymous(
  //       anonymouslyUser: KTestText.user,
  //       anonymouslyUserSetting: KTestText.userSetting,
  //     ),
  //   ],
  // );

  // blocTest<AuthenticationBloc, AuthenticationState>(
  //   'emits [AuthenticationState.unknown] when'
  //   ' AuthenticationStatusChanged',
  //   build: () => authenticationBloc,
  //   act: (bloc) async {
  //     when(mockAuthenticationRepository.user).thenAnswer(
  //       (realInvocation) => Stream.value(User.empty),
  //     );
  //     bloc.add(
  //       AuthenticationInitialized(),
  //     );
  //   },
  //   expect: () async => [
  //     const AuthenticationState.unknown(),
  //   ],
  // );
  // group('Call AuthenticationInitialized auto', () {
  //   setUp(() {
  //     when(mockAuthenticationRepository.currectAuthenticationStatus)
  //         .thenAnswer(
  //       (realInvocation) => AuthenticationStatus.authenticated,
  //     );
  //     when(mockAuthenticationRepository.status).thenAnswer(
  //       (realInvocation) => Stream.value(AuthenticationStatus.authenticated),
  //     );
  //     // authenticationBloc.add(AuthenticationInitialized());
  //   });
  //   // blocTest<AuthenticationBloc, AuthenticationState>(
  //   //   'emits [AuthenticationState] when'
  //   //   ' AppLanguageChanged',
  //   //   build: () => authenticationBloc,
  //   //   act: (bloc) async {
  //   //     bloc.add(
  //   //       const AppLanguageChanged(),
  //   //     );
  //   //   },
  //   //   expect: () async => [
  //   //     const AuthenticationState.authenticated(
  //   //       currentUser: KTestText.user,
  //   //       currentUserSetting: KTestText.userSetting,
  //   //     ),
  //   //     AuthenticationState.authenticated(
  //   //       currentUser: KTestText.user,
  //   //       currentUserSetting:
  //   //           KTestText.userSetting.copyWith(locale: Language.english),
  //   //     ),
  //   //   ],
  //   // );
  //   blocTest<AuthenticationBloc, AuthenticationState>(
  //     'emits [AuthenticationState] when'
  //     ' AuthenticationLogoutRequested',
  //     build: () => authenticationBloc,
  //     act: (bloc) async {
  //       bloc.add(
  //         AuthenticationLogoutRequested(),
  //       );
  //     },
  //     expect: () => [
  //       const AuthenticationState.authenticated(),
  //     ],
  //   );
  //   // blocTest<AuthenticationBloc, AuthenticationState>(
  //   //   'emits [AuthenticationState] when'
  //   //   ' AppUserRoleChanged',
  //   //   build: () => authenticationBloc,
  //   //   act: (bloc) async {
  //   //     bloc.add(
  //   //       const AppUserRoleChanged(UserRole.veteran),
  //   //     );
  //   //   },
  //   //   expect: () => [
  //   //     const AuthenticationState.authenticated(
  //   //       currentUser: KTestText.user,
  //   //       currentUserSetting: KTestText.userSetting,
  //   //     ),
  //   //     AuthenticationState.authenticated(
  //   //       currentUser: KTestText.user,
  //   //       currentUserSetting:
  //   //           KTestText.userSetting.copyWith(userRole: UserRole.veteran),
  //   //     ),
  //   //   ],
  //   // );
  //   blocTest<AuthenticationBloc, AuthenticationState>(
  //     'emits [AuthenticationState] when'
  //     ' AuthenticationDeleteRequested',
  //     build: () => authenticationBloc,
  //     act: (bloc) async {
  //       bloc.add(
  //         AuthenticationDeleteRequested(),
  //       );
  //     },
  //     expect: () => [
  //       const AuthenticationState.authenticated(),
  //     ],
  //   );
  // });
  // });
}
