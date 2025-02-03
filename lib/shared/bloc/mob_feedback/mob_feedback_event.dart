part of 'mob_feedback_bloc.dart';

@freezed
class MobFeedbackEvent with _$MobFeedbackEvent {
  const factory MobFeedbackEvent.messageUpdated(String message) =
      _MessageUpdated;
  const factory MobFeedbackEvent.emailUpdated(String email) = _EmailUpdated;
  const factory MobFeedbackEvent.send(Uint8List? image) = _Send;
}
