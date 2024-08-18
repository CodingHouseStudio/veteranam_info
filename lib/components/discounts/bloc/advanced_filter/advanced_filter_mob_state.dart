part of 'advanced_filter_mob_cubit.dart';

@freezed
class AdvancedFilterMobState with _$AdvancedFilterMobState {
  const factory AdvancedFilterMobState({
    required List<dynamic> filtersLocation,
    required List<DiscountEnum> sorting,
    // required List<ReportModel> reportItems,
  }) = _Initial;
}
