import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

part 'work_employee_watcher_event.dart';
part 'work_employee_watcher_state.dart';
part 'work_employee_watcher_bloc.freezed.dart';

@Injectable()
class WorkEmployeeWatcherBloc
    extends Bloc<WorkEmployeeWatcherEvent, WorkEmployeeWatcherState> {
  WorkEmployeeWatcherBloc({required IWorkRepository workRepository})
      : _workRepository = workRepository,
        super(
          const _Initial(
            workModelItems: [],
            loadingStatus: LoadingStatus.initial,
            filteredWorkModelItems: [],
            categories: null,
            cities: null,
            page: 0,
            failure: null,
            maxPage: 0,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
    on<_LoadPage>(_onLoadPage);
    on<_FilterCities>(_onFilterCities);
    on<_FilterCategories>(_onFilterCategories);
    on<_FilterReset>(_onFilterReset);
  }
  final IWorkRepository _workRepository;
  StreamSubscription<List<WorkModel>>? _workItemsSubscription;
  Future<void> _onStarted(
    _Started event,
    Emitter<WorkEmployeeWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    await _workItemsSubscription?.cancel();
    _workItemsSubscription = _workRepository.getWorks().listen(
      (work) => add(
        WorkEmployeeWatcherEvent.updated(
          work,
        ),
      ),
      onError: (dynamic error) {
        debugPrint('error is $error');
        add(WorkEmployeeWatcherEvent.failure(error));
      },
    );
  }

  void _onUpdated(
    _Updated event,
    Emitter<WorkEmployeeWatcherState> emit,
  ) {
    final filterItems = _filter(
      cities: state.cities,
      categories: state.categories,
      workModelItems: event.workItemsModel,
    );
    final workItems = _changePage(
      page: event.workItemsModel.isEmpty || state.page != 0 ? state.page : 1,
      workModelItems: filterItems,
    );
    emit(
      WorkEmployeeWatcherState(
        workModelItems: event.workItemsModel,
        loadingStatus: LoadingStatus.loaded,
        filteredWorkModelItems: workItems,
        cities: state.cities,
        categories: state.categories,
        page: event.workItemsModel.isEmpty || state.page != 0 ? state.page : 1,
        maxPage: event.workItemsModel.isNotEmpty
            ? (event.workItemsModel.length / KDimensions.pagetItems).ceil()
            : 0,
        failure: null,
      ),
    );
  }

  void _onLoadPage(
    _LoadPage event,
    Emitter<WorkEmployeeWatcherState> emit,
  ) {
    if (event.page > state.maxPage ||
        state.page == event.page ||
        event.page <= 0) return;
    final filterItems = _filter(
      cities: state.cities,
      categories: state.categories,
      workModelItems: state.workModelItems,
    );
    final workItems =
        _changePage(page: event.page, workModelItems: filterItems);
    emit(
      state.copyWith(
        filteredWorkModelItems: workItems,
        page: event.page,
      ),
    );
  }

  void _onFilterReset(
    _FilterReset event,
    Emitter<WorkEmployeeWatcherState> emit,
  ) {
    emit(
      state.copyWith(
        filteredWorkModelItems: _changePage(
          page:
              state.workModelItems.isEmpty || state.page != 0 ? state.page : 1,
          workModelItems: state.workModelItems,
        ),
        page: state.workModelItems.isEmpty || state.page != 0 ? state.page : 1,
        categories: null,
        cities: null,
        maxPage: (state.workModelItems.length / KDimensions.pagetItems).ceil(),
      ),
    );
  }

  void _onFilterCities(
    _FilterCities event,
    Emitter<WorkEmployeeWatcherState> emit,
  ) {
    final filterItems = _filter(
      cities: event.cities,
      categories: state.categories,
      workModelItems: state.workModelItems,
    );
    final maxPage = (filterItems.length / KDimensions.pagetItems).ceil();
    final workItems =
        _changePage(page: state.page, workModelItems: filterItems);
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loaded,
        filteredWorkModelItems: workItems,
        cities: event.cities,
        page: workItems.isNotEmpty
            ? maxPage >= state.page
                ? state.page
                : maxPage
            : 0,
        maxPage: maxPage,
      ),
    );
  }

  void _onFilterCategories(
    _FilterCategories event,
    Emitter<WorkEmployeeWatcherState> emit,
  ) {
    final filterItems = _filter(
      cities: state.cities,
      categories: event.categories,
      workModelItems: state.workModelItems,
    );
    final maxPage = (filterItems.length / KDimensions.pagetItems).ceil();
    final workItems = _changePage(
      page: state.page == 0 && filterItems.isNotEmpty ? 1 : state.page,
      workModelItems: filterItems,
    );
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loaded,
        filteredWorkModelItems: workItems,
        categories: event.categories,
        page: workItems.isNotEmpty
            ? maxPage >= state.page
                ? state.page == 0
                    ? 1
                    : state.page
                : maxPage
            : 0,
        maxPage: maxPage,
      ),
    );
  }

  List<WorkModel> _filter({
    required String? cities,
    required String? categories,
    required List<WorkModel> workModelItems,
  }) {
    if (cities != null || categories != null) {
      final filterItems = workModelItems
          .where(
            (element) =>
                (categories == null ||
                    element.category == null ||
                    element.category!.contains(categories)) &&
                (cities == null ||
                    element.city == null ||
                    element.city!.contains(cities)),
          )
          .toList();
      return filterItems;
    } else {
      return workModelItems;
    }
  }

  List<WorkModel> _changePage({
    required int page,
    required List<WorkModel> workModelItems,
  }) {
    if (workModelItems.isNotEmpty) {
      if (page == 1) {
        return workModelItems.sublist(
          0,
          workModelItems.length > KDimensions.pagetItems
              ? KDimensions.pagetItems
              : workModelItems.length,
        );
      }
      for (var i = page * KDimensions.pagetItems;
          i > 0;
          i -= KDimensions.pagetItems) {
        if (i <= workModelItems.length + KDimensions.pagetItems) {
          return workModelItems.sublist(
            i - KDimensions.pagetItems,
            i <= workModelItems.length ? i : workModelItems.length,
          );
        }
      }
    }
    return workModelItems;
  }

  void _onFailure(
    _Failure event,
    Emitter<WorkEmployeeWatcherState> emit,
  ) {
    debugPrint('error is ${event.failure}');
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.error,
        failure: const SomeFailure.serverError().toWork(),
      ),
    );
  }

  @override
  Future<void> close() {
    _workItemsSubscription?.cancel();
    return super.close();
  }
}
