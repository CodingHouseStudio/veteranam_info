import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Injectable()
class AuthenticationServicesCubit
    extends Cubit<AuthenticationServicesFailure?> {
  AuthenticationServicesCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(AuthenticationServicesFailure.initial);
  final AuthenticationRepository _authenticationRepository;
  Future<void> authenticationUseGoogle() async {
    final result = await _authenticationRepository.signUpWithGoogle();
    result.fold(
      (l) => emit(
        l._toAuthenticationServicesFailure(),
      ),
      (r) => emit(
        null,
      ),
    );
  }

  Future<void> authenticationUseFacebook() async {
    final result = await _authenticationRepository.signUpWithFacebook();
    result.fold(
      (l) => emit(
        l._toAuthenticationServicesFailure(),
      ),
      (r) => emit(
        null,
      ),
    );
  }
}

enum AuthenticationServicesFailure {
  error,
  initial,
}

extension AuthenticationServicesFailureExtentions on SomeFailure {
  AuthenticationServicesFailure _toAuthenticationServicesFailure() {
    return AuthenticationServicesFailure.error;
  }
}
