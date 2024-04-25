import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'questions_form_watcher_event.dart';
part 'questions_form_watcher_state.dart';
part 'questions_form_watcher_bloc.freezed.dart';

class QuestionsFormWatcherBloc
    extends Bloc<QuestionsFormWatcherEvent, QuestionsFormWatcherState> {
  QuestionsFormWatcherBloc() : super(const _Initial()) {
    on<QuestionsFormWatcherEvent>((event, emit) {});
  }
}
