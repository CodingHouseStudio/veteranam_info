import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@injectable
class CheckVerificationCodeCubit extends Cubit<bool?> {
  CheckVerificationCodeCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(
          null,
        );

  final UserRepository _userRepository;

  Future<void> started(String? code) async {
    final result = await _userRepository.checkVerificationCode(code);

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
