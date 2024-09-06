import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

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
            failure: null,
            fieldsIsCorrect: null,
            showPasswordField: false,
          ),
        ) {
    on<_EmailUpdated>(_onEmailUpdated);
    on<_PasswordUpdated>(_onPasswordUpdated);
    on<_SignUpSubmitted>(_onSignUpSubmitted);
    on<_PasswordFieldHide>(_onPasswordFieldHide);
  }

  final IAppAuthenticationRepository _iAppAuthenticationRepository;

  Future<void> _onEmailUpdated(
    _EmailUpdated event,
    Emitter<SignUpState> emit,
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
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(
        password: PasswordFieldModel.dirty(event.password),
        failure: null,
      ),
    );
  }

  Future<void> _onSignUpSubmitted(
    _SignUpSubmitted event,
    Emitter<SignUpState> emit,
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
      final result = await _iAppAuthenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      emit(
        result.fold(
          (l) => state.copyWith(
            failure: l._toSignUpError(),
            showPasswordField: false,
          ),
          (r) => state.copyWith(
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
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(showPasswordField: false),
    );
  }
}
