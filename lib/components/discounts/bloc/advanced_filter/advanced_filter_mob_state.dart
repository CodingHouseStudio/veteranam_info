part of 'advanced_filter_mob_cubit.dart';

@freezed
class AdvancedFilterMobState with _$AdvancedFilterMobState {
  const factory AdvancedFilterMobState({
    required List<FilterItem<String>> filtersLocation,
    required List<FilterItem<DiscountEnum>> sorting,
    required List<FilterItem<String>> choosenLocationList,
    required List<FilterItem<DiscountEnum>> choosenSortingnList,
    // required List<ReportModel> reportItems,
  }) = _Initial;
}
