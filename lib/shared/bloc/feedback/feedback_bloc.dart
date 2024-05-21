import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';
part 'feedback_bloc.freezed.dart';

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
            failure: FeedbackFailure.initial,
          ),
        ) {
    on<_NameUpdated>(_onNameUpdated);
    on<_EmailUpdated>(_onEmailUpdated);
    on<_MessageUpdated>(_onMessageUpdated);
    on<_Save>(_onSave);
    on<_Clear>(_onClear);
    on<_SendignMessageAgain>(_onSendignMessageAgain);
  }

  final IFeedbackRepository _feedbackRepository;

  final IAppAuthenticationRepository _appAuthenticationRepository;

  void _onNameUpdated(
    _NameUpdated event,
    Emitter<FeedbackState> emit,
  ) {
    final nameFieldModel = NameFieldModel.dirty(event.name);
    emit(
      state.copyWith(
        name: nameFieldModel,
        formState: FeedbackEnum.initial,
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
        formState: FeedbackEnum.initial,
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
        formState: FeedbackEnum.initial,
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
    if (Formz.validate(
      [
        state.message,
        state.email,
        state.name,
      ],
    )) {
      emit(state.copyWith(formState: FeedbackEnum.sendingMessage));
      final result = await _feedbackRepository.sendFeedback(
        FeedbackModel(
          id: ExtendedDateTime.id,
          guestId: _appAuthenticationRepository.currentUser.id,
          guestName: state.name.value!,
          email: state.email.value,
          timestamp: ExtendedDateTime.current,
          message: state.message.value,
        ),
      );
      result.fold(
        (l) => emit(
          state.copyWith(
            failure: l.toFeedback(),
            formState: FeedbackEnum.invalidData,
          ),
        ),
        (r) => emit(
          const FeedbackState(
            email: EmailFieldModel.pure(),
            message: MessageFieldModel.pure(),
            name: NameFieldModel.pure(),
            formState: FeedbackEnum.success,
            failure: FeedbackFailure.none,
          ),
        ),
      );

      await _appAuthenticationRepository.updateUserSetting(
        _appAuthenticationRepository.currentUserSetting.copyWith(
          timeSendingFeedback: ExtendedDateTime.current,
        ),
      );
    } else {
      emit(state.copyWith(formState: FeedbackEnum.invalidData));
    }
  }

  void _onClear(
    _Clear event,
    Emitter<FeedbackState> emit,
  ) {
    if (state.formState != FeedbackEnum.initial &&
        state.formState != FeedbackEnum.invalidData) return;
    emit(
      const FeedbackState(
        email: EmailFieldModel.pure(),
        message: MessageFieldModel.pure(),
        name: NameFieldModel.pure(),
        formState: FeedbackEnum.clear,
        failure: FeedbackFailure.initial,
      ),
    );
  }

  void _onSendignMessageAgain(
    _SendignMessageAgain event,
    Emitter<FeedbackState> emit,
  ) {
    emit(
      state.copyWith(
        formState: FeedbackEnum.sendignMessageAgain,
      ),
    );
  }
}

/// FOLDER FILES COMMENT: Blocks that are used on several pages
