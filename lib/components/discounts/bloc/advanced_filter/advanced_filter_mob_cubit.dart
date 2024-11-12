import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/components/discounts/bloc/watcher/discount_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'advanced_filter_mob_state.dart';
part 'advanced_filter_mob_cubit.freezed.dart';

@Injectable(env: [Config.user])
class AdvancedFilterMobCubit extends Cubit<AdvancedFilterMobState> {
  AdvancedFilterMobCubit()
      : super(
          const AdvancedFilterMobState(
            filtersLocation: [],
            sorting: [],
            choosenLocationList: [],
            choosenSortingnList: [],
          ),
        );
  void started({
    required List<FilterItem> initialFilter,
    required List<SortingItem> initialSorting,
    required List<FilterItem> initChooseLocationList,
    required List<SortingItem> initialChooseSorting,
  }) =>
      emit(
        AdvancedFilterMobState(
          filtersLocation: initialFilter,
          sorting: initialSorting,
          choosenLocationList: initChooseLocationList,
          choosenSortingnList: initialChooseSorting,
        ),
      );

  void changeFilterList(dynamic value) {
    final chooseLocation = state.choosenLocationList.checkValue(
      filterValue: FilterItem(value),
      equalValue: null,
    );
    final filterList = state.filtersLocation
        .map(
          (element) => element.value == value
              ? element.copyWith(isSelected: !element.isSelected)
              : element,
        )
        .toList();
    // checkValue(
    //   filterValue: value,
    //   equalValue: SubLocation.allStoresOfChain,
    // );
    emit(
      state.copyWith(
        filtersLocation: filterList,
        choosenLocationList: chooseLocation,
      ),
    );
  }

  void sorting(DiscountEnum value) {
    final chooseSorting = state.choosenSortingnList.checkValue(
      filterValue: SortingItem(value),
      equalValue: null,
    );
    final sorting = state.sorting
        .map(
          (element) => element.value == value
              ? element.copyWith(isSelected: !element.isSelected)
              : element,
        )
        .toList();

    emit(
      state.copyWith(
        choosenSortingnList: chooseSorting,
        sorting: sorting,
      ),
    );
  }

  // void reset() {
  //   emit(
  //     const AdvancedFilterMobState(
  //       filtersLocation: [],
  //       sorting: [],
  //     ),
  //   );
  // }
}
