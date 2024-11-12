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
          ),
        );
  void started({
    required List<FilterItem> initialFilter,
    required List<DiscountEnum> initialSorting,
    required List<FilterItem> initChoosenLocationList,
  }) =>
      emit(
        AdvancedFilterMobState(
          filtersLocation: initialFilter,
          sorting: initialSorting,
          choosenLocationList: initChoosenLocationList,
        ),
      );

  void changeFilterList(dynamic value) {
    final filterList = state.filtersLocation
      ..map(
        (element) => element.value == value
            ? element.copyWith(isSelected: !element.isSelected)
            : element,
      ).toList();
    // checkValue(
    //   filterValue: value,
    //   equalValue: SubLocation.allStoresOfChain,
    // );
    emit(state.copyWith(filtersLocation: filterList));
  }

  void sorting(DiscountEnum value) {
    final sorting = state.sorting.checkValue(
      filterValue: value,
      equalValue: null,
    );
    emit(state.copyWith(sorting: sorting));
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
