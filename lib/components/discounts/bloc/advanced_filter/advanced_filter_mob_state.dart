part of 'advanced_filter_mob_cubit.dart';

@freezed
class AdvancedFilterMobState with _$AdvancedFilterMobState {
  const factory AdvancedFilterMobState({
    required List<FilterItem> filtersLocation,
    required List<SortingItem> sorting,
    required List<FilterItem> choosenLocationList,
    required List<SortingItem> choosenSortingnList,
    // required List<ReportModel> reportItems,
  }) = _Initial;
}
