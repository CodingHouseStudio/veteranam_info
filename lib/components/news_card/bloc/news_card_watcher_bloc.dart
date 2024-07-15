import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'news_card_watcher_event.dart';
part 'news_card_watcher_state.dart';
part 'news_card_watcher_bloc.freezed.dart';

@Injectable()
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
          failure: NewsCardFailure.wrongID,
        ),
      );
      return;
    }
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    final resault = await _informationRepository.getInformation(event.id!);

    resault.fold(
      (l) => emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          failure: l._toNewsCard(),
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
