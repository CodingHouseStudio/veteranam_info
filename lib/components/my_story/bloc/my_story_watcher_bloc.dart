import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_story_watcher_event.dart';
part 'my_story_watcher_state.dart';
part 'my_story_watcher_bloc.freezed.dart';

class MyStoryWatcherBloc extends Bloc<MyStoryWatcherEvent, MyStoryWatcherState> {
  MyStoryWatcherBloc() : super(_Initial()) {
    on<MyStoryWatcherEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
