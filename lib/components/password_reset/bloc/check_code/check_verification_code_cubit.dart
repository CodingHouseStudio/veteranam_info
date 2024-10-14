import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@injectable
class CheckVerificationCodeCubit extends Cubit<bool?> {
  CheckVerificationCodeCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          null,
        );

  final AuthenticationRepository _authenticationRepository;

  Future<void> started(String? code) async {
    final result = await _authenticationRepository.checkVerificationCode(code);

    result.fold(
      (l) => emit(
        false,
      ),
      (r) => emit(
        true,
      ),
    );
  }
}
