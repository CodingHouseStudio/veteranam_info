import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

part 'investors_watcher_event.dart';
part 'investors_watcher_state.dart';
part 'investors_watcher_bloc.freezed.dart';

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
    on<_LoadNextItems>(_onLoading);
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
          failure: l.toInvestors(),
          loadingStatus: LoadingStatus.error,
        ),
      ),
      (r) => emit(
        InvestorsWatcherState(
          fundItems: r,
          loadingStatus: LoadingStatus.loaded,
          loadingFundItems: _loading(
            itemsLoaded: KDimensions.investorsLoadItems,
            fundModelItems: r,
          ),
          itemsLoaded: KDimensions.investorsLoadItems,
        ),
      ),
    );
  }

  Future<void> _onLoading(
    _LoadNextItems event,
    Emitter<InvestorsWatcherState> emit,
  ) async {
    if (state.itemsLoaded + KDimensions.investorsLoadItems >
        state.fundItems.length) {
      return;
    }
    final filterItems = _loading(
      itemsLoaded: state.itemsLoaded + KDimensions.investorsLoadItems,
      fundModelItems: state.fundItems,
    );
    emit(
      state.copyWith(
        loadingFundItems: filterItems,
        itemsLoaded: filterItems.length > state.itemsLoaded
            ? state.itemsLoaded + KDimensions.investorsLoadItems
            : filterItems.length,
      ),
    );
  }

  List<FundModel> _loading({
    required int itemsLoaded,
    required List<FundModel> fundModelItems,
  }) {
    if (fundModelItems.isEmpty) return [];
    final loadedItemsCount = itemsLoaded.clamp(0, fundModelItems.length);

    return fundModelItems.take(loadedItemsCount).toList();
  }
}
