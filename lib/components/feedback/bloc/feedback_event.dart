part of 'feedback_bloc.dart';

@freezed
sealed class FeedbackEvent with _$FeedbackEvent {
  const factory FeedbackEvent.started() = _Started;
  const factory FeedbackEvent.nameUpdated(String name) = _NameUpdated;
  const factory FeedbackEvent.emailUpdated(String email) = _EmailUpdated;
  const factory FeedbackEvent.messageUpdated(String message) = _MessageUpdated;
  const factory FeedbackEvent.save() = _Save;
  // const factory FeedbackEvent.clear() = _Clear;
  const factory FeedbackEvent.sendignMessageAgain() = _SendignMessageAgain;
}
