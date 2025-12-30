import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared_dart.dart';

part 'authentication_services_state.dart';

@injectable
class AuthenticationServicesCubit extends Cubit<AuthenticationServicesState> {
  AuthenticationServicesCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          const AuthenticationServicesState(
            status: AuthenticationServicesStatus.init,
          ),
        );
  final AuthenticationRepository _authenticationRepository;
  Future<void> authenticationUseGoogle() async {
    if (!isClosed) {
      emit(
        const AuthenticationServicesState(
          status: AuthenticationServicesStatus.procesing,
        ),
      );
    }
    final result = await _authenticationRepository.signUpWithGoogle();
    if (!isClosed) {
      result.fold(
        (l) => emit(
          AuthenticationServicesState(
            status: AuthenticationServicesStatus.error,
            failure: l,
          ),
        ),
        (r) => emit(
          AuthenticationServicesState(
            status: r
                ? AuthenticationServicesStatus.authentication
                : AuthenticationServicesStatus.init,
          ),
        ),
      );
    }
  }

  Future<void> authenticationUseApple() async {
    if (!isClosed) {
      emit(
        const AuthenticationServicesState(
          status: AuthenticationServicesStatus.procesing,
        ),
      );
    }

    final result = await _authenticationRepository.signUpWithApple();
    if (!isClosed) {
      result.fold(
        (l) => emit(
          AuthenticationServicesState(
            status: AuthenticationServicesStatus.error,
            failure: l,
          ),
        ),
        (r) => emit(
          const AuthenticationServicesState(
            status: AuthenticationServicesStatus.authentication,
          ),
        ),
      );
    }
  }

  Future<void> authenticationUseFacebook() async {
    if (!isClosed) {
      emit(
        const AuthenticationServicesState(
          status: AuthenticationServicesStatus.procesing,
        ),
      );
    }
    final result = await _authenticationRepository.signUpWithFacebook();
    if (!isClosed) {
      result.fold(
        (l) => emit(
          AuthenticationServicesState(
            status: AuthenticationServicesStatus.error,
            failure: l,
          ),
        ),
        (r) => emit(
          const AuthenticationServicesState(
            status: AuthenticationServicesStatus.authentication,
          ),
        ),
      );
    }
  }
}

// enum AuthenticationServicesFailure {
//   error,
//   initial,
// }

// extension AuthenticationServicesFailureExtentions on SomeFailure {
//   AuthenticationServicesFailure _toAuthenticationServicesFailure() {
//     return AuthenticationServicesFailure.error;
//   }
// }
