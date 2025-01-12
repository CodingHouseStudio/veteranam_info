import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'pw_reset_email_event.dart';
part 'pw_reset_email_state.dart';
part 'pw_reset_email_bloc.freezed.dart';

@injectable
class PwResetEmailBloc extends Bloc<PwResetEmailEvent, PwResetEmailState> {
  PwResetEmailBloc({
    required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _appAuthenticationRepository = appAuthenticationRepository,
        super(
          const _Initial(
            email: EmailFieldModel.pure(),
            formState: PwResetEmailEnum.initial,
            failure: null,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_EmailUpdated>(_onEmailUpdated);
    on<_SendResetCode>(_onSendResetCode);
    on<_ResetStatus>(_onResetStatus);
  }

  final IAppAuthenticationRepository _appAuthenticationRepository;

  void _onStarted(
    _Started event,
    Emitter<PwResetEmailState> emit,
  ) {
    if (event.email != null) {
      _emailUpdated(
        email: event.email!,
        emit: emit,
      );
    }
  }

  void _onResetStatus(
    _ResetStatus event,
    Emitter<PwResetEmailState> emit,
  ) {
    emit(
      state.copyWith(
        formState: PwResetEmailEnum.inProgress,
      ),
    );
  }

  void _onEmailUpdated(
    _EmailUpdated event,
    Emitter<PwResetEmailState> emit,
  ) {
    _emailUpdated(
      email: event.email,
      emit: emit,
    );
  }

  void _emailUpdated({
    required String email,
    required Emitter<PwResetEmailState> emit,
  }) {
    emit(
      _Initial(
        email: EmailFieldModel.dirty(email),
        failure: null,
        formState: PwResetEmailEnum.inProgress,
      ),
    );
  }

  Future<void> _onSendResetCode(
    _SendResetCode event,
    Emitter<PwResetEmailState> emit,
  ) async {
    if (state.email.isValid) {
      emit(
        state.copyWith(
          formState: state.formState == PwResetEmailEnum.success
              ? PwResetEmailEnum.resending
              : PwResetEmailEnum.sending,
        ),
      );
      final result = await _appAuthenticationRepository.sendVerificationCode(
        email: state.email.value,
      );
      result.fold(
        (l) => emit(
          state.copyWith(
            failure: l,
            formState: PwResetEmailEnum.inProgress,
          ),
        ),
        (r) => emit(
          state.copyWith(
            failure: null,
            formState: PwResetEmailEnum.success,
          ),
        ),
      );
    } else {
      emit(state.copyWith(formState: PwResetEmailEnum.invalidData));
    }
  }
}
