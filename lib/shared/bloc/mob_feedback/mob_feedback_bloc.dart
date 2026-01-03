import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'mob_feedback_event.dart';
part 'mob_feedback_state.dart';
part 'mob_feedback_bloc.freezed.dart';

@Injectable(env: [Config.mobile])
class MobFeedbackBloc extends Bloc<MobFeedbackEvent, MobFeedbackState> {
  MobFeedbackBloc({
    required IFeedbackRepository feedbackRepository,
    required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _feedbackRepository = feedbackRepository,
        _appAuthenticationRepository = appAuthenticationRepository,
        super(
          const _Initial(
            message: MessageFieldModel.pure(),
            email: EmailFieldModel.pure(),
            failure: null,
            formState: MobFeedbackEnum.initial,
          ),
        ) {
    on<_MessageUpdated>(_onMessageUpdated);
    on<_EmailUpdated>(_onEmailUpdated);
    on<_Send>(_onSend);
  }
  final IFeedbackRepository _feedbackRepository;
  final IAppAuthenticationRepository _appAuthenticationRepository;

  Future<void> _onMessageUpdated(
    _MessageUpdated event,
    Emitter<MobFeedbackState> emit,
  ) async {
    final messageFieldModel = MessageFieldModel.dirty(event.message);
    emit(
      state.copyWith(
        message: messageFieldModel,
        formState: MobFeedbackEnum.inProgress,
      ),
    );
  }

  Future<void> _onEmailUpdated(
    _EmailUpdated event,
    Emitter<MobFeedbackState> emit,
  ) async {
    final emailFieldModel = EmailFieldModel.dirty(event.email);
    emit(
      state.copyWith(
        email: emailFieldModel,
        formState: MobFeedbackEnum.inProgress,
      ),
    );
  }

  Future<void> _onSend(
    _Send event,
    Emitter<MobFeedbackState> emit,
  ) async {
    if (state.message.isValid &&
        (state.email.isValid ||
            (_appAuthenticationRepository.currentUser.email?.isNotEmpty ??
                false)) &&
        event.image != null) {
      final feedbackModel = FeedbackModel(
        id: ExtendedDateTime.id,
        guestId: _appAuthenticationRepository.currentUser.id,
        guestName: _appAuthenticationRepository.currentUser.name,
        email: state.email.isNotValid
            ? _appAuthenticationRepository.currentUser.email ?? ''
            : state.email.value,
        timestamp: ExtendedDateTime.current,
        message: state.message.value,
      );
      final result = await _feedbackRepository.sendMobFeedback(
        feedback: feedbackModel,
        image: event.image!,
      );
      result.fold(
        (l) => emit(state.copyWith(failure: l)),
        (r) => emit(
          const _Initial(
            message: MessageFieldModel.pure(),
            email: EmailFieldModel.pure(),
            failure: null,
            formState: MobFeedbackEnum.success,
          ),
        ),
      );
    } else {
      emit(state.copyWith(formState: MobFeedbackEnum.invalidData));
    }
  }
}
