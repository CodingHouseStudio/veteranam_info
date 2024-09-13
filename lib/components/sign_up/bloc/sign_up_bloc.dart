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
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          const SignUpState(
            email: EmailFieldModel.pure(),
            password: PasswordFieldModel.pure(),
            failure: null,
            formState: SignUpEnum.initial,
          ),
        ) {
    on<_EmailUpdated>(_onEmailUpdated);
    on<_PasswordUpdated>(_onPasswordUpdated);
    on<_SignUpSubmitted>(_onSignUpSubmitted);
    on<_PasswordFieldHide>(_onPasswordFieldHide);
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onEmailUpdated(
    _EmailUpdated event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(
        email: EmailFieldModel.dirty(event.email),
        failure: null,
        formState: SignUpEnum.inProgress,
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
        formState: SignUpEnum.passwordInProgress,
      ),
    );
  }

  Future<void> _onSignUpSubmitted(
    _SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    if (state.email.isValid && state.formState == SignUpEnum.inProgress) {
      emit(
        state.copyWith(
          formState: SignUpEnum.showPassword,
          failure: null,
        ),
      );
      return;
    }
    if (Formz.validate([
      state.password,
      state.email,
    ])) {
      emit(
        state.copyWith(
          formState: SignUpEnum.success,
        ),
      );
      // emit(state.copyWith(fieldsIsCorrect: true));
      final result = await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      emit(
        result.fold(
          (l) => state.copyWith(
            failure: l._toSignUpError(),
            formState: SignUpEnum.initial,
          ),
          (r) => const SignUpState(
            email: EmailFieldModel.pure(),
            password: PasswordFieldModel.pure(),
            failure: null,
            formState: SignUpEnum.success,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          formState: state.email.isValid
              ? SignUpEnum.passwordInvalidData
              : SignUpEnum.invalidData,
        ),
      );
    }
  }

  Future<void> _onPasswordFieldHide(
    _PasswordFieldHide event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(formState: SignUpEnum.inProgress),
    );
  }
}
