import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'user_watcher_event.dart';
part 'user_watcher_state.dart';
part 'user_watcher_bloc.freezed.dart';

@injecatable
class UserWatcherBloc extends Bloc<UserWatcherEvent, UserWatcherState> {
  UserWatcherBloc() : super(_Initial()) {
    on<UserWatcherEvent>((event, emit) {
    });
  }
}
