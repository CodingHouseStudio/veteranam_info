import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@Injectable()
class AuthenticationServicesCubit extends Cubit<AuthenticationServicesFailure> {
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
        AuthenticationServicesFailure.none,
      ),
    );
  }
}

enum AuthenticationServicesFailure {
  none,
  error,
  initial,
}

extension AuthenticationServicesFailureExtentions on SomeFailure {
  AuthenticationServicesFailure _toAuthenticationServicesFailure() {
    return AuthenticationServicesFailure.error;
  }
}
