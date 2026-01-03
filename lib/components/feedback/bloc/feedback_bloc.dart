import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'feedback_bloc.freezed.dart';
part 'feedback_event.dart';
part 'feedback_state.dart';

@Injectable()
class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc({
    required IFeedbackRepository feedbackRepository,
    required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _feedbackRepository = feedbackRepository,
        _appAuthenticationRepository = appAuthenticationRepository,
        super(
          const _FeedbackState(
            email: EmailFieldModel.pure(),
            message: MessageFieldModel.pure(),
            name: NameFieldModel.pure(),
            formState: FeedbackEnum.initial,
            failure: null,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_NameUpdated>(_onNameUpdated);
    on<_EmailUpdated>(_onEmailUpdated);
    on<_MessageUpdated>(_onMessageUpdated);
    on<_Save>(_onSave);
    // on<_Clear>(_onClear);
    on<_SendignMessageAgain>(_onSendignMessageAgain);
  }

  final IFeedbackRepository _feedbackRepository;
  final IAppAuthenticationRepository _appAuthenticationRepository;

  Future<void> _onStarted(
    _Started event,
    Emitter<FeedbackState> emit,
  ) async {
    if (_appAuthenticationRepository.currentUser.isEmpty) {
      return;
    }
    final result = await _feedbackRepository
        .checkUserNeedShowFeedback(_appAuthenticationRepository.currentUser.id);
    result.fold(
        (l) => emit(
              state.copyWith(
                failure: l,
                formState: FeedbackEnum.initial,
              ),
            ), (r) {
      if (r) {
        emit(
          state.copyWith(
            formState: FeedbackEnum.initial,
            failure: null,
          ),
        );
      } else {
        emit(
          state.copyWith(
            formState: FeedbackEnum.notShow,
          ),
        );
      }
    });
  }

  void _onNameUpdated(
    _NameUpdated event,
    Emitter<FeedbackState> emit,
  ) {
    final nameFieldModel = NameFieldModel.dirty(event.name);
    emit(
      state.copyWith(
        name: nameFieldModel,
        formState: FeedbackEnum.inProgress,
        failure: null,
      ),
    );
  }

  void _onEmailUpdated(
    _EmailUpdated event,
    Emitter<FeedbackState> emit,
  ) {
    final emailFieldModel = EmailFieldModel.dirty(event.email);
    emit(
      state.copyWith(
        email: emailFieldModel,
        formState: FeedbackEnum.inProgress,
        failure: null,
      ),
    );
  }

  void _onMessageUpdated(
    _MessageUpdated event,
    Emitter<FeedbackState> emit,
  ) {
    final messageFieldModel = MessageFieldModel.dirty(event.message);
    emit(
      state.copyWith(
        message: messageFieldModel,
        formState: FeedbackEnum.inProgress,
        failure: null,
      ),
    );
  }

  Future<void> _onSave(
    _Save event,
    Emitter<FeedbackState> emit,
  ) async {
    if (_appAuthenticationRepository.currentUser.isEmpty) {
      return;
    }
    if (state.message.isValid &&
        (state.email.isValid ||
            (_appAuthenticationRepository.currentUser.email?.isNotEmpty ??
                false)) &&
        (state.name.isValid ||
            (_appAuthenticationRepository.currentUser.name?.isNotEmpty ??
                false))) {
      emit(state.copyWith(formState: FeedbackEnum.sendingMessage));
      final result = await _feedbackRepository.sendFeedback(
        FeedbackModel(
          id: ExtendedDateTime.id,
          guestId: _appAuthenticationRepository.currentUser.id,
          guestName:
              _appAuthenticationRepository.currentUser.name ?? state.name.value,
          email: _appAuthenticationRepository.currentUser.email ??
              state.email.value,
          timestamp: ExtendedDateTime.current,
          message: state.message.value,
        ),
      );
      result.fold(
        (l) => emit(
          state.copyWith(
            failure: l,
            formState: FeedbackEnum.initial,
          ),
        ),
        (r) => emit(
          const FeedbackState(
            email: EmailFieldModel.pure(),
            message: MessageFieldModel.pure(),
            name: NameFieldModel.pure(),
            formState: FeedbackEnum.success,
            failure: null,
          ),
        ),
      );
    } else {
      emit(state.copyWith(formState: FeedbackEnum.invalidData));
    }
  }

  // void _onClear(
  //   _Clear event,
  //   Emitter<FeedbackState> emit,
  // ) {
  //   if (state.formState == FeedbackEnum.initial ||
  //       state.formState == FeedbackEnum.invalidData ||
  //       state.formState == FeedbackEnum.clear) return;
  //   emit(
  //     const FeedbackState(
  //       email: EmailFieldModel.pure(),
  //       message: MessageFieldModel.pure(),
  //       name: NameFieldModel.pure(),
  //       formState: FeedbackEnum.clear,
  //       failure: null,
  //     ),
  //   );
  // }

  void _onSendignMessageAgain(
    _SendignMessageAgain event,
    Emitter<FeedbackState> emit,
  ) {
    emit(
      state.copyWith(
        formState: FeedbackEnum.sendignMessageAgain,
      ),
    );

    emit(
      const FeedbackState(
        email: EmailFieldModel.pure(),
        message: MessageFieldModel.pure(),
        name: NameFieldModel.pure(),
        formState: FeedbackEnum.initial,
        failure: null,
      ),
    );
    // add(const FeedbackEvent.clear());
  }
}

/// FOLDER FILES COMMENT: Blocks that are used on several pages
