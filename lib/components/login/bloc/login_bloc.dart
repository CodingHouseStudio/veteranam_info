import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          const LoginState(
            email: EmailFieldModel.pure(),
            password: PasswordFieldModel.pure(),
            failure: null,
            formState: LoginEnum.initial,
          ),
        ) {
    on<_EmailUpdated>(_onEmailUpdated);
    on<_PasswordUpdated>(_onPasswordUpdated);
    on<_LoginSubmitted>(_onLoginSubmitted);
    on<_PasswordFieldHide>(_onPasswordFieldHide);
    on<_SendSignInLinkToEmail>(_onSendSignInLinkToEmail);
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onEmailUpdated(
    _EmailUpdated event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        email: EmailFieldModel.dirty(event.email),
        failure: null,
        formState: LoginEnum.inProgress,
      ),
    );
  }

  Future<void> _onPasswordUpdated(
    _PasswordUpdated event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        password: PasswordFieldModel.dirty(event.password),
        failure: null,
        formState: LoginEnum.passwordInProgress,
      ),
    );
  }

  Future<void> _onLoginSubmitted(
    _LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.email.isValid && state.formState == LoginEnum.inProgress) {
      emit(
        state.copyWith(
          formState: LoginEnum.showPassword,
          failure: null,
        ),
      );
      return;
    }
    if (Formz.validate([
      state.password,
      state.email,
    ])) {
      // emit(state.copyWith(fieldsIsCorrect: true));
      final result = await _authenticationRepository.logIn(
        email: state.email.value,
        password: state.password.value,
      );

      result.fold(
        (l) => emit(
          state.copyWith(
            failure: l._toLogInError(),
            formState: LoginEnum.inProgress,
          ),
        ),
        (r) => emit(
          state.copyWith(
            failure: null,
            formState: LoginEnum.inProgress,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          formState: state.email.isValid
              ? LoginEnum.passwordInvalidData
              : LoginEnum.invalidData,
        ),
      );
    }
  }

  Future<void> _onPasswordFieldHide(
    _PasswordFieldHide event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(formState: LoginEnum.inProgress),
    );
  }

  Future<void> _onSendSignInLinkToEmail(
    _SendSignInLinkToEmail event,
    Emitter<LoginState> emit,
  ) async {
    if (state.email.isValid) {
      final result = await _authenticationRepository.sendSignInLinkToEmail(
        state.email.value,
      );

      result.fold(
        (l) => emit(
          state.copyWith(
            failure: l._toLogInError(),
            formState: LoginEnum.inProgress,
          ),
        ),
        (r) => emit(
          state.copyWith(
            failure: null,
            formState: LoginEnum.inProgress,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          formState: LoginEnum.invalidData,
        ),
      );
    }
  }
}
