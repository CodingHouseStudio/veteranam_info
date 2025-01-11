import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/models/discount_model.dart';
import 'package:veteranam/shared/models/failure_model/some_failure.dart';
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

  /// Toggles an existing category filter.
  /// Updates the Activity categories filter
  /// and available filter lists accordingly.
  Either<SomeFailure, bool> addCategory({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
  });

  /// Toggles an existing location filter.
  /// Updates the activity location filter
  /// and available filter lists accordingly.
  Either<SomeFailure, bool> addLocation({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
  });

  /// Toggles an existing eligibilities filter.
  /// Updates the Activity eligibilities
  /// filter and available filter lists accordingly.
  Either<SomeFailure, bool> addEligibility({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
  });

  /// Serch location value in the location map.
  /// Search value in the uk and en values
  Either<SomeFailure, bool> locationSearch(String? value);

  /// Clear values in the Activity map
  Either<SomeFailure, bool> resetAll(
    List<DiscountModel> unmodifiedDiscountModelItems,
  );

  /// Filters the given list of discount items based on the Activity filters.
  ///
  /// Only items that contain all filters in the cosen list.
  Either<SomeFailure, List<DiscountModel>> getFilterList(
    List<DiscountModel> unmodifiedDiscountModelItems,
  );

  /// Saves the current active filter state. The saved state can be reverted
  /// using the [revertActiveFilter] method.
  Either<SomeFailure, bool> saveActiveFilter();

  /// Reverts the current active filter to the previously saved state using
  /// the [saveActiveFilter] method.
  Either<SomeFailure, bool> revertActiveFilter(
    List<DiscountModel> unmodifiedDiscountModelItems,
  );

  Either<SomeFailure, bool> getFilterValuesFromDiscountItems(
    List<DiscountModel> unmodifiedDiscountModelItems,
  );

  /// Checks if any filters are currently activity in any dimension.
  bool get hasActivityItem;

  bool get locationIsNotEpmty;

  bool get saveFilterEqual;

  /// Combines all Activity filters into a single map.
  Map<String, FilterItem> get getActivityList;
}
