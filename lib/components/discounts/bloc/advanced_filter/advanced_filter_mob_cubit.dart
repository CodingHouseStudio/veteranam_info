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
            choosenLocationList: [],
            choosenCategoriesnList: [],
            filterCategory: [],
            choosenEligibilitiesList: [],
            filterEligibilities: [],
          ),
        );
  void started({
    required List<FilterItem<String>> initialLocationFilter,
    required List<FilterItem<String>> initialCategories,
    required List<FilterItem<String>> initialEligibilities,
    required List<FilterItem<String>> initChooseLocationList,
    required List<FilterItem<String>> initialChooseCategories,
    required List<FilterItem<String>> initialChooseEligibilities,
  }) =>
      emit(
        AdvancedFilterMobState(
          filtersLocation: initialLocationFilter,
          choosenLocationList: initChooseLocationList,
          filterCategory: initialCategories,
          choosenCategoriesnList: initialChooseCategories,
          filterEligibilities: initialEligibilities,
          choosenEligibilitiesList: initialChooseEligibilities,
        ),
      );

  void changeCategoriesList(String value) {
    final filterList = state.filterCategory
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
        filterCategory: filterList,
        choosenCategoriesnList: filterList
            .where(
              (element) => element.isSelected,
            )
            .toList(),
      ),
    );
  }

  void changeLocationsList(String value) {
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

  void changeEligibilitiesList(String value) {
    final filterList = state.filterEligibilities
        .map(
          (element) => element.value == value
              ? element.copyWith(isSelected: !element.isSelected)
              : element,
        )
        .toList();
    emit(
      state.copyWith(
        filterEligibilities: filterList,
        choosenEligibilitiesList: filterList
            .where(
              (element) => element.isSelected,
            )
            .toList(),
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
