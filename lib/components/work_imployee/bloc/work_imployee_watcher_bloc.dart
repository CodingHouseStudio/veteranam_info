import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kozak/shared/shared.dart';

part 'work_imployee_watcher_event.dart';
part 'work_imployee_watcher_state.dart';
part 'work_imployee_watcher_bloc.freezed.dart';

class WorkImployeeWatcherBloc
    extends Bloc<WorkImployeeWatcherEvent, WorkImployeeWatcherState> {
  WorkImployeeWatcherBloc({required IWorkRepository workRepository})
      : _workRepository = workRepository,
        super(
          const WorkImployeeWatcherState(
            informationModelItems: [],
            loadingStatus: LoadingStatus.initial,
            filteredInformationModelItems: [],
            filters: null,
            page: 1,
            failure: null,
          ),) {
    on<_Started>(_onStarted);
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
    on<_LoadNextPage>(_onLoadNextPage);
    on<_Filter>(_onFilter);
    on<_FilterReset>(_onFilterReset);
  }
  final IWorkRepository _workRepository;
  StreamSubscription<List<WorkModel>>? _workItemsSubscription;

  Future<void> _onStarted(
    _Started event,
    Emitter<WorkImployeeWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    await _workItemsSubscription?.cancel();
    _workItemsSubscription =
        _workRepository.getWorks().listen(
      (information) => add(
        WorkWatcherEvent.updated(
          information,
        ),
      ),
      onError: (dynamic error) {
        debugPrint('error is $error');
        add(WorkWatcherEvent.failure(error));
      },
    );
  }

  void _onUpdated(
    _Updated event,
    Emitter<WorkImployeeWatcherState> emit,
  ) {
    emit(
      WorkImployeeWatcherState(
        informationModelItems: event.informationItemsModel,
        loadingStatus: LoadingStatus.loaded,
        filteredInformationModelItems: _filter(
          filters: state.filters,
          page: state.page + 1,
          informationModelItems: event.informationItemsModel,
        ),
        filters: null,
        page: event.informationItemsModel.isNotEmpty ? 1 : 0,
        failure: null,
      ),
    );
  }

  void _onLoadNextPage(
    _LoadNextPage event,
    Emitter<InformationWatcherState> emit,
  ) {
    // if (state.itemsLoaded + 1 > state.informationModelItems.length) return;
    // final filterItems = _filter(
    //   filters: state.filters,
    //   itemsLoaded: state.itemsLoaded + 1,
    //   informationModelItems: state.informationModelItems,
    // );
    // emit(
    //   state.copyWith(
    //     filteredInformationModelItems: filterItems,
    //     itemsLoaded: filterItems.length > state.itemsLoaded
    //         ? state.itemsLoaded + 1
    //         : filterItems.length,
    //   ),
    // );
  }

  void _onFilterReset(
    _FilterReset event,
    Emitter<WorkImployeeWatcherState> emit,
  ) {
    emit(
      state.copyWith(
        filteredInformationModelItems: _filter(
          filters: null,
          page: state.page,
          informationModelItems: state.informationModelItems,
        ),
        filters: null,
      ),
    );
  }

  void _onFilter(
    _Filter event,
    Emitter<WorkImployeeWatcherState> emit,
  ) {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    final selectedFilters = List<String>.from(state.filters ?? []);

    event.isSelected ?? false
        ? selectedFilters.add(event.filter!)
        : selectedFilters.remove(event.filter);

    final filterItems = _filter(
      filters: selectedFilters,
      informationModelItems: state.informationModelItems,
      page: state.page,
    );

    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loaded,
        filteredInformationModelItems: filterItems,
        filters: selectedFilters,
        page: filterItems.length >= state.page
            ? state.page
            : filterItems.length,
      ),
    );
  }

  List<InformationModel> _filter({
    required List<String>? filters,
    required int itemsLoaded,
    required List<InformationModel> informationModelItems,
  }) {
    if (itemsLoaded > informationModelItems.length) {
      itemsLoaded = informationModelItems.length;
    }
    if (filters != null && filters.isNotEmpty) {
      final filterItems = informationModelItems
          .where(
            (element) =>
                element.tags == null ||
                filters.any(
                  (filter) => element.tags!.contains(filter),
                ),
          )
          .toList();
      return filterItems.sublist(
        0,
        itemsLoaded > filterItems.length ? filterItems.length : itemsLoaded,
      );
    } else {
      return informationModelItems.sublist(
        0,
        itemsLoaded > informationModelItems.length
            ? informationModelItems.length
            : itemsLoaded,
      );
    }
  }

  void _onFailure(
    _Failure event,
    Emitter<WorkImployeeWatcherState> emit,
  ) {
    debugPrint('error is ${event.failure}');
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.error,
        failure: const SomeFailure.serverError().toInformation(),
      ),
    );
  }

  @override
  Future<void> close() {
    _informationItemsSubscription?.cancel();
    return super.close();
  }
}
