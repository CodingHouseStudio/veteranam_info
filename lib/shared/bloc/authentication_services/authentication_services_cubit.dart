import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Injectable()
class AuthenticationServicesCubit extends Cubit<AuthenticationServicesFailure> {
  AuthenticationServicesCubit({
    required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _appAuthenticationRepository = appAuthenticationRepository,
        super(AuthenticationServicesFailure.initial);
  final IAppAuthenticationRepository _appAuthenticationRepository;
  Future<void> authenticationUseGoogle() async {
    final result = await _appAuthenticationRepository.signUpWithGoogle();
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
