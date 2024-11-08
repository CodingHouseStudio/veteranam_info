import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'investors_watcher_bloc.freezed.dart';
part 'investors_watcher_event.dart';
part 'investors_watcher_state.dart';

/// Bloc for handling investors data loading and watching.
/// Manages the state of investors loading, provides pagination, and separates
/// data into lists for mobile and desktop layouts.
@Injectable()
class InvestorsWatcherBloc
    extends Bloc<InvestorsWatcherEvent, InvestorsWatcherState> {
  /// Initializes the bloc with required repository and sets the initial state.
  InvestorsWatcherBloc({
    required IInvestorsRepository investorsRepository,
  })  : _investorsRepository = investorsRepository,
        super(
          const InvestorsWatcherState(
            loadingStatus: LoadingStatusInvestors.initial,
            // loadingDeskFundItems: [],
            fundItems: [],
            // loadingMobFundItems: [],
            // itemsLoaded: 0,
            failure: null,
            deskFundItems: [],
            // loadedFull: false,
          ),
        ) {
    on<_Started>(_onStarted);
    // on<_LoadNextItems>(_loadNextItems);
  }

  /// Repository to fetch investors' funds data.
  final IInvestorsRepository _investorsRepository;

  /// List to store fetched funds.
  late List<FundModel> fundsList;

  /// Handler for the `_Started` event, which is triggered on the initial load.
  /// Fetches data from the repository and updates the state based
  /// on the result.
  Future<void> _onStarted(
    _Started event,
    Emitter<InvestorsWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatusInvestors.loading));

    // Fetch funds from the repository
    final result = await _investorsRepository.getFunds();
    result.fold(
      (l) => emit(
        state.copyWith(
          failure: l._toInvestors(),
          loadingStatus: LoadingStatusInvestors.error,
        ),
      ),
      (r) {
        // Process and split the list for desktop view
        // final loadingItems = _loading(
        //   itemsLoaded: state.itemsLoaded,
        //   loadItems: KDimensions.investorsLoadItems,
        //   list: r,
        // );
        emit(
          InvestorsWatcherState(
            fundItems: r,
            deskFundItems: getDeskList(r),
            loadingStatus: LoadingStatusInvestors.loaded,
            // loadedFull: r.length < KDimensions.investorsLoadItems,
            // loadingMobFundItems: loadingItems,
            // itemsLoaded: KDimensions.investorsLoadItems,
            failure: null,
          ),
        );
      },
    );
  }

  /// Helper function to organize the list of funds into a desktop-friendly
  /// format.
  /// Splits the list into sublists based on a predefined number of items per
  /// row (`donateCardsLine`).
  List<List<FundModel>> getDeskList(List<FundModel> fundModel) {
    final deskFundsModelItems = <List<FundModel>>[];

    for (var i = 0; i < fundModel.length; i += KDimensions.donateCardsLine) {
      if (i + KDimensions.donateCardsLine <= fundModel.length) {
        deskFundsModelItems
            .add(fundModel.sublist(i, i + KDimensions.donateCardsLine));
      } else {
        deskFundsModelItems.add(fundModel.sublist(i));
      }
    }
    return deskFundsModelItems;
  }

  /// Handler for the `_LoadNextItems` event, used to load additional items
  /// as part of pagination.
  /// Checks if more items are available and updates the state accordingly.
  // Future<void> _loadNextItems(
  //   _LoadNextItems event,
  //   Emitter<InvestorsWatcherState> emit,
  // ) async {
  //   if (state.itemsLoaded.checkLoadingPosible(state.fundItems)) {
  //     emit(state.copyWith(loadedFull: true));
  //     return;
  //   }

  //   emit(state.copyWith(loadingStatus: LoadingStatusInvestors.loading));

  //   // Load more items for pagination
  //   final filterItems = _loading(
  //     itemsLoaded: state.itemsLoaded,
  //     loadItems: KDimensions.investorsLoadItems,
  //   );

  //   emit(
  //     state.copyWith(
  //       loadingMobFundItems: filterItems,
  //       loadingDeskFundItems: getDeskList(filterItems),
  //       itemsLoaded: filterItems.length,
  //       loadingStatus: LoadingStatusInvestors.loaded,
  //       loadedFull: filterItems.length == state.fundItems.length,
  //     ),
  //   );
  // }

  /// Internal function to get a sublist of items for loading, based on
  /// `itemsLoaded` and `loadItems`.
  /// Useful for pagination to avoid reloading already-loaded items.
  // List<FundModel> _loading({
  //   required int itemsLoaded,
  //   required int? loadItems,
  //   List<FundModel>? list,
  // }) {
  //   return (list ?? state.fundItems).loading(
  //     itemsLoaded: itemsLoaded,
  //     loadItems: loadItems,
  //   );
  // }
}
