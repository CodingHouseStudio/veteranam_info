import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'information_watcher_event.dart';
part 'information_watcher_state.dart';
part 'information_watcher_bloc.freezed.dart';

class InformationWatcherBloc extends Bloc<InformationWatcherEvent, InformationWatcherState> {
  InformationWatcherBloc() : super(_Initial()) {
    on<InformationWatcherEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
