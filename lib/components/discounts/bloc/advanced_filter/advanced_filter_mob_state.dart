part of 'advanced_filter_mob_cubit.dart';

@freezed
class AdvancedFilterMobState with _$AdvancedFilterMobState {
  const factory AdvancedFilterMobState({
    required List<FilterItem> filtersLocation,
    required List<FilterItem> choosenLocationList,
    required List<FilterItem> choosenCategoriesnList,
    required List<FilterItem> filterCategory,
    required List<FilterItem> choosenEligibilitiesList,
    required List<FilterItem> filterEligibilities,
    // required List<ReportModel> reportItems,
  }) = _Initial;
}
