part of 'mob_faq_watcher_bloc.dart';

@freezed
sealed class MobFaqWatcherEvent with _$MobFaqWatcherEvent {
  const factory MobFaqWatcherEvent.started() = _Started;
}
