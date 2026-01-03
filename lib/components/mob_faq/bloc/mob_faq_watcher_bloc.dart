import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'mob_faq_wathcer_event.dart';
part 'mob_faq_watcher_state.dart';
part 'mob_faq_watcher_bloc.freezed.dart';

@Injectable(env: [Config.mobile])
class MobFaqWatcherBloc extends Bloc<MobFaqWatcherEvent, MobFaqWatcherState> {
  MobFaqWatcherBloc({required IFaqRepository faqRepository})
      : _faqRepository = faqRepository,
        super(
          const MobFaqWatcherState(
            questionModelItems: [],
            loadingStatus: LoadingStatus.initial,
          ),
        ) {
    on<_Started>(_onStarted);
    add(const MobFaqWatcherEvent.started());
  }
  final IFaqRepository _faqRepository;
  Future<void> _onStarted(
    _Started event,
    Emitter<MobFaqWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    final result = await _faqRepository.getQuestions();
    result.fold(
      (l) => emit(
        state.copyWith(
          failure: l,
          loadingStatus: LoadingStatus.error,
        ),
      ),
      (r) => emit(
        MobFaqWatcherState(
          questionModelItems: r,
          loadingStatus: LoadingStatus.loaded,
        ),
      ),
    );
  }
}
