import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'mob_faq_wathcer_event.dart';
part 'mob_faq_watcher_state.dart';
part 'mob_faq_watcher_bloc.freezed.dart';

@injectable
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
          failure: l._toMobFAQ(),
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