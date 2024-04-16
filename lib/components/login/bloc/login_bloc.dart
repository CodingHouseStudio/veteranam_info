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
            fieldsState: FieldEnum.initial,
            showPassword: false,
          ),
        ) {
    on<_EmailUpdated>(_onEmailUpdated);
    on<_PasswordUpdated>(_onPasswordUpdated);
    on<_LoginSubmitted>(_onLoginSubmitted);
    on<_PasswordHide>(_onPasswordHide);
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onEmailUpdated(
    _EmailUpdated event,
    Emitter<LoginState> emit,
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
    Emitter<LoginState> emit,
  ) async {
    final passwordFieldModel = PasswordFieldModel.dirty(event.password);
    emit(
      state.copyWith(
        password: passwordFieldModel,
        fieldsState: FieldEnum.inProgress,
      ),
    );
  }

  Future<void> _onLoginSubmitted(
    _LoginSubmitted event,
    Emitter<LoginState> emit,
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
      final result = await _authenticationRepository.logIn(
        email: state.email.value,
        password: state.password.value,
      );

      result.fold(
        (l) => emit(
          state.copyWith(
            failure: l.toLogInError(),
            fieldsState: FieldEnum.invalidData,
            showPassword: false,
          ),
        ),
        (r) => emit(
          state.copyWith(
            failure: LoginError.none,
          ),
        ),
      );
    } else {
      emit(state.copyWith(fieldsState: FieldEnum.invalidData));
    }
  }

  Future<void> _onPasswordHide(
    _PasswordHide event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(showPassword: false, fieldsState: FieldEnum.inProgress),
    );
  }
}
