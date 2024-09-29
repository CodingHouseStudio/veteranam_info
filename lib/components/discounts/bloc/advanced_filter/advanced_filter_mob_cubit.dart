import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared.dart';

part 'advanced_filter_mob_state.dart';
part 'advanced_filter_mob_cubit.freezed.dart';

@injectable
class AdvancedFilterMobCubit extends Cubit<AdvancedFilterMobState> {
  AdvancedFilterMobCubit()
      : super(
          const AdvancedFilterMobState(
            filtersLocation: [],
            sorting: [],
          ),
        );
  void started({
    required List<dynamic> initialFilter,
    required List<DiscountEnum> initialSorting,
  }) =>
      emit(
        AdvancedFilterMobState(
          filtersLocation: initialFilter,
          sorting: initialSorting,
        ),
      );

  void changeFilterList(dynamic value) {
    final filterList = state.filtersLocation.checkValue(
      filterValue: value,
      equalValue: SubLocation.allStoresOfChain,
    );
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
