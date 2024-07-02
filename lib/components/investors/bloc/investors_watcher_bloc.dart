import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'investors_watcher_bloc.freezed.dart';
part 'investors_watcher_event.dart';
part 'investors_watcher_state.dart';

@Injectable()
class InvestorsWatcherBloc
    extends Bloc<InvestorsWatcherEvent, InvestorsWatcherState> {
  InvestorsWatcherBloc({required IInvestorsRepository investorsRepository})
      : _investorsRepository = investorsRepository,
        super(
          const InvestorsWatcherState(
            fundItems: [],
            loadingStatus: LoadingStatus.initial,
            loadingFundItems: [],
            itemsLoaded: 0,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_LoadNextItems>(_loadNextItems);
  }
  final IInvestorsRepository _investorsRepository;
  Future<void> _onStarted(
    _Started event,
    Emitter<InvestorsWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    final result = await _investorsRepository.getFunds();
    result.fold(
      (l) => emit(
        state.copyWith(
          failure: l._toInvestors(),
          loadingStatus: LoadingStatus.error,
        ),
      ),
      (r) => emit(
        InvestorsWatcherState(
          fundItems: r,
          loadingStatus: LoadingStatus.loaded,
          loadingFundItems: r.loading(
            itemsLoaded: KDimensions.investorsLoadItems,
            loadItems: KDimensions.investorsLoadItems,
          ),
          itemsLoaded: KDimensions.investorsLoadItems,
        ),
      ),
    );
  }

  Future<void> _loadNextItems(
    _LoadNextItems event,
    Emitter<InvestorsWatcherState> emit,
  ) async {
    if (state.itemsLoaded.checkLoadingPosible(state.fundItems)) {
      emit(state.copyWith(loadingStatus: LoadingStatus.listLoadedFull));
      return;
    }

    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    final filterItems = state.fundItems.loading(
      itemsLoaded: state.itemsLoaded + KDimensions.investorsLoadItems,
      loadItems: KDimensions.investorsLoadItems,
    );
    emit(
      state.copyWith(
        loadingFundItems: filterItems,
        itemsLoaded:
            (state.itemsLoaded + KDimensions.investorsLoadItems).getLoaded(
          list: filterItems,
          loadItems: KDimensions.investorsLoadItems,
        ),
        loadingStatus: LoadingStatus.loaded,
      ),
    );
  }
}
