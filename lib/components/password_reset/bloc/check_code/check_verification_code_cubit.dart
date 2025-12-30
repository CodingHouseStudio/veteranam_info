import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared_dart.dart';

@injectable
class CheckVerificationCodeCubit extends Cubit<bool?> {
  CheckVerificationCodeCubit({
    required IAppAuthenticationRepository appAuthenticationRepository,
    @factoryParam required String? code,
  })  : _appAuthenticationRepository = appAuthenticationRepository,
        super(
          null,
        ) {
    _started(code);
  }

  final IAppAuthenticationRepository _appAuthenticationRepository;

  Future<void> _started(String? code) async {
    final result =
        await _appAuthenticationRepository.checkVerificationCode(code);

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
