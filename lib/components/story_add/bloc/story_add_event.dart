part of 'story_add_bloc.dart';

@freezed
sealed class StoryAddEvent with _$StoryAddEvent {
  const factory StoryAddEvent.storyUpdated(String story) = _StoryUpdated;
  const factory StoryAddEvent.imageUpdated() = _ImageUpdated;
  const factory StoryAddEvent.anonymouslyUpdated() = _AnonymouslyUpdated;
  const factory StoryAddEvent.save() = _Save;
}
