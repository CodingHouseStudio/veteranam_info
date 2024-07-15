part of 'news_card_watcher_bloc.dart';

@freezed
class NewsCardWatcherEvent with _$NewsCardWatcherEvent {
  const factory NewsCardWatcherEvent.started(String? id) = _Started;
}
