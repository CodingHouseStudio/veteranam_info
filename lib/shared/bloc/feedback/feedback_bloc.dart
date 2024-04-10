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
  FeedbackBloc()
      : super(
          const _FeedbackState(
            email: EmailFieldModel.pure(),
            message: MessageFieldModel.pure(),
            name: NameFieldModel.pure(),
            fieldsState: FeedbackEnum.initial,
          ),
        ) {
    on<_NameUpdated>(_onNameUpdated);
    on<_EmailUpdated>(_onEmailUpdated);
    on<_MessageUpdated>(_onMessageUpdated);
    on<_Save>(_onSave);
    on<_Clear>(_onClear);
  }

  Future<void> _onNameUpdated(
    _NameUpdated event,
    Emitter<FeedbackState> emit,
  ) async {
    final nameFieldModel = NameFieldModel.dirty(event.name);
    emit(
      state.copyWith(
        name: nameFieldModel,
        fieldsState: FeedbackEnum.inProgress,
      ),
    );
  }

  Future<void> _onEmailUpdated(
    _EmailUpdated event,
    Emitter<FeedbackState> emit,
  ) async {
    final emailFieldModel = EmailFieldModel.dirty(event.email);
    emit(
      state.copyWith(
        email: emailFieldModel,
        fieldsState: FeedbackEnum.inProgress,
      ),
    );
  }

  Future<void> _onMessageUpdated(
    _MessageUpdated event,
    Emitter<FeedbackState> emit,
  ) async {
    final messageFieldModel = MessageFieldModel.dirty(event.message);
    emit(
      state.copyWith(
        message: messageFieldModel,
        fieldsState: FeedbackEnum.inProgress,
      ),
    );
  }

  Future<void> _onSave(
    _Save event,
    Emitter<FeedbackState> emit,
  ) async {
    if (Formz.validate(
      [
        state.message,
        state.email,
        state.name,
      ],
    )) {
      emit(
        const FeedbackState(
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          name: NameFieldModel.pure(),
          fieldsState: FeedbackEnum.success,
        ),
      );
    } else {
      emit(state.copyWith(fieldsState: FeedbackEnum.invalidData));
    }
  }

  Future<void> _onClear(
    _Clear event,
    Emitter<FeedbackState> emit,
  ) async {
    emit(
      const FeedbackState(
        email: EmailFieldModel.pure(),
        message: MessageFieldModel.pure(),
        name: NameFieldModel.pure(),
        fieldsState: FeedbackEnum.initial,
      ),
    );
  }
}
