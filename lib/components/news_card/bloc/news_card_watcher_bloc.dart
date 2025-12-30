import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared_dart.dart';

part 'news_card_watcher_event.dart';
part 'news_card_watcher_state.dart';
part 'news_card_watcher_bloc.freezed.dart';

@Injectable(env: [Config.development])
class NewsCardWatcherBloc
    extends Bloc<NewsCardWatcherEvent, NewsCardWatcherState> {
  NewsCardWatcherBloc({
    required IInformationRepository informationRepository,
  })  : _informationRepository = informationRepository,
        super(
          const _Initial(
            informationModel: null,
            loadingStatus: LoadingStatus.initial,
            failure: null,
          ),
        ) {
    on<_Started>(_onStarted);
  }
  final IInformationRepository _informationRepository;
  Future<void> _onStarted(
    _Started event,
    Emitter<NewsCardWatcherState> emit,
  ) async {
    if (event.id == null || event.id!.isEmpty) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          failure: SomeFailure.wrongID,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
        failure: null,
      ),
    );

    final result = await _informationRepository.getInformation(event.id!);

    result.fold(
      (l) => emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          failure: l,
        ),
      ),
      (r) => emit(
        NewsCardWatcherState(
          informationModel: r,
          loadingStatus: LoadingStatus.loaded,
          failure: null,
        ),
      ),
    );
  }
}
