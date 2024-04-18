import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

part 'login_bloc.freezed.dart';

part 'login_event.dart';

part 'login_state.dart';

@Injectable()
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          const LoginState(
            email: EmailFieldModel.pure(),
            password: PasswordFieldModel.pure(),
            failure: LoginError.initial,
            fieldsIsCorrect: null,
            showPasswordField: false,
          ),
        ) {
    on<_EmailUpdated>(_onEmailUpdated);
    on<_PasswordUpdated>(_onPasswordUpdated);
    on<_LoginSubmitted>(_onLoginSubmitted);
    on<_PasswordFieldHide>(_onPasswordFieldHide);
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onEmailUpdated(
    _EmailUpdated event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        email: EmailFieldModel.dirty(event.email),
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
      final result = await _authenticationRepository.logIn(
        email: state.email.value,
        password: state.password.value,
      );

      result.fold(
        (l) => emit(
          state.copyWith(
            failure: l.toLogInError(),
            showPasswordField: false,
          ),
        ),
        (r) => emit(
          state.copyWith(
            failure: LoginError.none,
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
