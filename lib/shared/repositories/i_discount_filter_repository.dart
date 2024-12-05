// ignore_for_file: avoid_unused_constructor_parameters

import 'package:veteranam/shared/models/discount_model.dart';
import 'package:veteranam/shared/models/filter_model.dart';

/// A model for managing and filtering discount items by categories, locations,
/// and eligibilities.
///
/// This class provides methods to manage filter criteria, apply those filters
/// to a list of items,
/// and dynamically update the filter lists based on the user's selections. It
/// operates on three
/// main dimensions: categories, locations, and eligibilities.
///
/// Each filter dimension is represented by a map where the keys are the filter
/// names
/// (in Ukrainian by default), and the values are `FilterItem` objects
/// containing metadata
/// about the filter (e.g., whether it is selected).
abstract class IDiscountFilterRepository {
  // Maps to store current available filters
  Map<String, FilterItem> get eligibilityMap;
  Map<String, FilterItem> get categoryMap;
  Map<String, FilterItem> get locationMap;

  // Maps to store current selected user filters
  Map<String, FilterItem> get activeEligibilityMap;
  Map<String, FilterItem> get activeCategoryMap;
  Map<String, FilterItem> get activeLocationMap;

  /// Set new values to map from List<DiscountModel>
  void getFilterValuesFromDiscountItems({
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  });

  /// Toggles an existing category filter.
  /// Updates the Activity categories filter
  /// and available filter lists accordingly.
  void addCategory({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  });

  /// Toggles an existing location filter.
  /// Updates the activity location filter
  /// and available filter lists accordingly.
  void addLocation({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  });

  /// Toggles an existing eligibilities filter.
  /// Updates the Activity eligibilities
  /// filter and available filter lists accordingly.
  void addEligibility({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  });

  /// Serch location value in the location map.
  /// Search value in the uk and en values
  void locationSearch(String? value);

  /// Clear values in the Activity map
  void resetAll({
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  });

  /// Filters the given list of discount items based on the Activity filters.
  ///
  /// Only items that contain all filters in the cosen list.
  List<DiscountModel> getFilterList(
    List<DiscountModel> unmodifiedDiscountModelItems,
  );

  /// Checks if any filters are currently activity in any dimension.
  bool get hasActivityItem;

  bool get locationIsNotEpmty;

  /// Combines all Activity filters into a single map.
  Map<String, FilterItem> get getActivityList;
}
