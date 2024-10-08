import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'password_reset_event.dart';
part 'password_reset_state.dart';
part 'password_reset_bloc.freezed.dart';

@injectable
class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  PasswordResetBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          const _Initial(
            password: PasswordFieldModel.pure(),
            confirmPassword: PasswordFieldModel.pure(),
            formState: PasswordResetEnum.initial,
            failure: null,
          ),
        ) {
    on<_PasswordUpdated>(_onPasswordUpdate);
    on<_ConfirmPasswordUpdated>(_onConfirmPasswordUpdate);
    on<_ResetPassword>(_onResetPassword);
    on<_Started>(_onStarted);
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onStarted(
    _Started event,
    Emitter<PasswordResetState> emit,
  ) async {
    final result =
        await _authenticationRepository.checkVerificationCode(code: event.code);

    result.fold(
      (l) => emit(
        _Initial(
          password: const PasswordFieldModel.pure(),
          confirmPassword: const PasswordFieldModel.pure(),
          formState: PasswordResetEnum.initial,
          failure: l._toPasswordResetError(),
        ),
      ),
      (r) => emit(
        const _Initial(
          password: PasswordFieldModel.pure(),
          confirmPassword: PasswordFieldModel.pure(),
          formState: PasswordResetEnum.codeValid,
          failure: null,
        ),
      ),
    );
  }

  void _onPasswordUpdate(
    _PasswordUpdated event,
    Emitter<PasswordResetState> emit,
  ) {
    emit(
      state.copyWith(
        password: PasswordFieldModel.dirty(event.password),
        failure: null,
        formState: PasswordResetEnum.inProgress,
      ),
    );
  }

  void _onConfirmPasswordUpdate(
    _ConfirmPasswordUpdated event,
    Emitter<PasswordResetState> emit,
  ) {
    emit(
      state.copyWith(
        confirmPassword: PasswordFieldModel.dirty(event.confirmPassword),
        failure: null,
        formState: PasswordResetEnum.inProgress,
      ),
    );
  }

  Future<void> _onResetPassword(
    _ResetPassword event,
    Emitter<PasswordResetState> emit,
  ) async {
    if (state.password != state.confirmPassword) {
      emit(state.copyWith(formState: PasswordResetEnum.passwordMismatch));
      return;
    }

    if (Formz.validate([state.password, state.confirmPassword])) {
      emit(state.copyWith(formState: PasswordResetEnum.sending));
      final result = await _authenticationRepository.resetPasswordUseCode(
        newPassword: state.password.value,
        code: event.code!,
      );
      result.fold(
        (l) => emit(
          state.copyWith(
            failure: l._toPasswordResetError(),
          ),
        ),
        (r) => emit(
          const _Initial(
            password: PasswordFieldModel.pure(),
            confirmPassword: PasswordFieldModel.pure(),
            failure: null,
            formState: PasswordResetEnum.success,
          ),
        ),
      );
    } else {
      emit(state.copyWith(formState: PasswordResetEnum.invalidData));
    }
  }
}
