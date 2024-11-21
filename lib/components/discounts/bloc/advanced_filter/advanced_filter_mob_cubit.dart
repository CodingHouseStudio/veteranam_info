import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
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
    required List<FilterItem<String>> initialLocationFilter,
    required List<FilterItem<DiscountEnum>> initialSorting,
    required List<FilterItem<String>> initChooseLocationList,
    required List<FilterItem<DiscountEnum>> initialChooseSorting,
  }) =>
      emit(
        AdvancedFilterMobState(
          filtersLocation: initialLocationFilter,
          sorting: initialSorting,
          choosenLocationList: initChooseLocationList,
          choosenSortingnList: initialChooseSorting,
        ),
      );

  void changeFilterList(dynamic value) {
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
        choosenLocationList: filterList
            .where(
              (element) => element.isSelected,
            )
            .toList(),
      ),
    );
  }

  void sorting(DiscountEnum value) {
    final sorting = state.sorting
        .map(
          (element) => element.value == value
              ? element.copyWith(isSelected: !element.isSelected)
              : element,
        )
        .toList();

    emit(
      state.copyWith(
        choosenSortingnList: sorting
            .where(
              (element) => element.isSelected,
            )
            .toList(),
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
