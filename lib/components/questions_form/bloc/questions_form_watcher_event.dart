part of 'questions_form_watcher_bloc.dart';

@freezed
class QuestionsFormWatcherEvent with _$QuestionsFormWatcherEvent {
  const factory QuestionsFormWatcherEvent.updateAnswer() = _UpdateAnswer;
}
