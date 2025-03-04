import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@injectable
class AuthenticationServicesCubit extends Cubit<SomeFailure?> {
  AuthenticationServicesCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(null);
  final AuthenticationRepository _authenticationRepository;
  Future<void> authenticationUseGoogle() async {
    final result = await _authenticationRepository.signUpWithGoogle();
    result.fold(
      emit,
      (r) => emit(
        null,
      ),
    );
  }

  Future<void> authenticationUseApple() async {
    final result = await _authenticationRepository.signUpWithApple();
    result.fold(
      emit,
      (r) => emit(
        null,
      ),
    );
  }

  Future<void> authenticationUseFacebook() async {
    final result = await _authenticationRepository.signUpWithFacebook();
    result.fold(
      emit,
      (r) => emit(
        null,
      ),
    );
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
