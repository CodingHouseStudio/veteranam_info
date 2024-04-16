import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

part 'sign_up_bloc.freezed.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required IAppAuthenticationRepository iAppAuthenticationRepository,
  })  : _iAppAuthenticationRepository = iAppAuthenticationRepository,
        super(
          const SignUpState(
            email: EmailFieldModel.pure(),
            password: PasswordFieldModel.pure(),
            failure: SignUpError.initial,
            fieldsState: FieldEnum.initial,
            showPassword: false,
          ),
        ) {
    on<_EmailUpdated>(_onEmailUpdated);
    on<_PasswordUpdated>(_onPasswordUpdated);
    on<_SignUpSubmitted>(_onSignUpSubmitted);
    on<_PasswordHide>(_onPasswordHide);
  }

  final IAppAuthenticationRepository _iAppAuthenticationRepository;

  Future<void> _onEmailUpdated(
    _EmailUpdated event,
    Emitter<SignUpState> emit,
  ) async {
    final emailFieldModel = EmailFieldModel.dirty(event.email);
    emit(
      state.copyWith(
        email: emailFieldModel,
        fieldsState: FieldEnum.inProgress,
      ),
    );
  }

  Future<void> _onPasswordUpdated(
    _PasswordUpdated event,
    Emitter<SignUpState> emit,
  ) async {
    final passwordFieldModel = PasswordFieldModel.dirty(event.password);
    emit(
      state.copyWith(
        password: passwordFieldModel,
        fieldsState: FieldEnum.inProgress,
      ),
    );
  }

  Future<void> _onSignUpSubmitted(
    _SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    if (Formz.validate([state.email]) && !state.showPassword) {
      emit(
        state.copyWith(
          showPassword: true,
          fieldsState: FieldEnum.initial,
        ),
      );
      return;
    }
    if (Formz.validate([
      state.password,
      state.email,
    ])) {
      emit(state.copyWith(fieldsState: FieldEnum.success));
      final result = await _iAppAuthenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      emit(
        result.fold(
          (l) => state.copyWith(
            failure: l.toSignUpError(),
            fieldsState: FieldEnum.invalidData,
            showPassword: false,
          ),
          (r) => state.copyWith(
            failure: SignUpError.none,
            fieldsState: FieldEnum.success,
          ),
        ),
      );
    } else {
      emit(state.copyWith(fieldsState: FieldEnum.invalidData));
    }
  }

  Future<void> _onPasswordHide(
    _PasswordHide event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(showPassword: false, fieldsState: FieldEnum.inProgress),
    );
  }
}
