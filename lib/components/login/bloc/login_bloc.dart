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
  LoginBloc({required IAppAuthenticationRepository appAuthenticationRepository})
      : _appAuthenticationRepository = appAuthenticationRepository,
        super(
          const LoginState(
            email: EmailFieldModel.pure(),
            password: PasswordFieldModel.pure(),
            failure: null,
            fieldsIsCorrect: null,
            showPasswordField: false,
          ),
        ) {
    on<_EmailUpdated>(_onEmailUpdated);
    on<_PasswordUpdated>(_onPasswordUpdated);
    on<_LoginSubmitted>(_onLoginSubmitted);
    on<_PasswordFieldHide>(_onPasswordFieldHide);
  }

  final IAppAuthenticationRepository _appAuthenticationRepository;

  Future<void> _onEmailUpdated(
    _EmailUpdated event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        email: EmailFieldModel.dirty(event.email),
        failure: null,
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
      ),
    );
  }

  Future<void> _onLoginSubmitted(
    _LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.email.isValid && !state.showPasswordField) {
      emit(
        state.copyWith(
          showPasswordField: true,
          failure: null,
          fieldsIsCorrect: null,
        ),
      );
      return;
    }
    if (Formz.validate([
      state.password,
      state.email,
    ])) {
      emit(state.copyWith(fieldsIsCorrect: true));
      final result =
          await _appAuthenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );

      result.fold(
        (l) => emit(
          state.copyWith(
            failure: l._toLogInError(),
            showPasswordField: false,
          ),
        ),
        (r) => emit(
          state.copyWith(
            failure: null,
            showPasswordField: false,
          ),
        ),
      );
    } else {
      emit(state.copyWith(fieldsIsCorrect: false));
    }
  }

  Future<void> _onPasswordFieldHide(
    _PasswordFieldHide event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(showPasswordField: false),
    );
  }
}
