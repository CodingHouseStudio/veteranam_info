import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';

import 'package:veteranam/shared/shared_dart.dart';

part 'discount_filter_private_repository.dart';

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
class DiscountFilterRepository extends _DiscountFilterRepository
    implements IDiscountFilterRepository {
  DiscountFilterRepository.init() : super.init();

  const DiscountFilterRepository.empty() : super.empty();

  /// Constructor to initialize maps.

  /// Constructor to initialize maps.
  // DiscountFilterRepository.init(
  //   List<DiscountModel> unmodifiedDiscountModelItems,
  // )   : _categoryMap = {},
  //       _activeCategoryMap = {},
  //       _mobSaveActiveCategoryMap = {},
  //       _locationMap = {},
  //       _locationSearchMap = {},
  //       _activeLocationMap = {},
  //       _mobSaveActiveLocationMap = {},
  //       _eligibilityMap = {},
  //       _activeEligibilityMap = {},
  //       _mobSaveActiveEligibilityMap = {},
  //       _mapEquality = const MapEquality() {
  //   getFilterValuesFromDiscountItems(
  //     unmodifiedDiscountModelItems,
  //   ).fold((l) => initError = l, Right.new);
  // }

  // Maps to store current available filters
  @override
  Map<String, FilterItem> get eligibilityMap => _eligibilityMap;
  @override
  Map<String, FilterItem> get categoryMap => _categoryMap;
  @override
  Map<String, FilterItem> get locationMap => _locationSearchMap;

  // Maps to store current selected user filters
  @override
  Map<String, FilterItem> get activeEligibilityMap => _activeEligibilityMap;
  @override
  Map<String, FilterItem> get activeCategoryMap => _activeCategoryMap;
  @override
  Map<String, FilterItem> get activeLocationMap => _activeLocationMap;

  /// Checks if any filters are currently activity in any dimension.
  @override
  bool get hasActivityItem =>
      _activeEligibilityMap.isNotEmpty ||
      _activeCategoryMap.isNotEmpty ||
      _activeLocationMap.isNotEmpty;

  @override
  bool get locationIsNotEpmty => _locationMap.isNotEmpty;

  @override
  bool get saveFilterEqual =>
      _mapEquality.equals(_activeCategoryMap, _mobSaveActiveCategoryMap) &&
      _mapEquality.equals(
        _activeEligibilityMap,
        _mobSaveActiveEligibilityMap,
      ) &&
      _mapEquality.equals(_activeLocationMap, _mobSaveActiveLocationMap);

  /// Combines all activity filters into a single map.
  @override
  Map<String, FilterItem> get getActivityList => {
        ..._activeEligibilityMap,
        ..._activeCategoryMap,
        ..._activeLocationMap,
      };

  /// Toggles an existing category filter.
  /// Updates the activity categories filter
  /// and available filter lists accordingly.
  @override
  Either<SomeFailure, bool> addRemoveCategory({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
  }) {
    return _addRemoveFilterItem(
      valueUK: valueUK,
      filter: _categoryMap,
      activityFilter: _activeCategoryMap,
      unmodifiedDiscountModelItems: unmodifiedDiscountModelItems,
      filterEnum: _FilterEnum.category,
      // callMethodName: 'addCategory',
    );
  }

  /// Toggles an existing location filter.
  /// Updates the activity location filter and available filter
  /// lists accordingly.
  @override
  Either<SomeFailure, bool> addRemoveLocation({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
  }) {
    return _addRemoveFilterItem(
      valueUK: valueUK,
      filter: _locationMap,
      activityFilter: _activeLocationMap,
      unmodifiedDiscountModelItems: unmodifiedDiscountModelItems,
      filterEnum: _FilterEnum.location,
      // callMethodName: 'addLocation',
    );
  }

  /// Toggles an existing eligibilities filter.
  /// Updates the activity eligibilities
  /// filter and available filter lists accordingly.
  @override
  Either<SomeFailure, bool> addRemoveEligibility({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
  }) {
    return _addRemoveFilterItem(
      valueUK: valueUK,
      filter: _eligibilityMap,
      activityFilter: _activeEligibilityMap,
      unmodifiedDiscountModelItems: unmodifiedDiscountModelItems,
      filterEnum: _FilterEnum.eligibility,
      // callMethodName: 'addEligibility',
    );
  }

  /// Serch location value in the location map.
  /// Search value in the uk and en values
  @override
  Either<SomeFailure, bool> locationSearch(String? value) =>
      _locationSearch(value);

  /// Clear values in the activity map
  @override
  Either<SomeFailure, bool> resetAll(
    List<DiscountModel> unmodifiedDiscountModelItems,
  ) {
    return eitherHelper(
      () {
        _activeCategoryMap.clear();
        _activeEligibilityMap.clear();
        _activeLocationMap.clear();

        return getFilterValuesFromDiscountItems(
          unmodifiedDiscountModelItems,
        );
      },
      user: _DiscountFilterRepository._userRepository.currentUser,
      userSetting: _DiscountFilterRepository._userRepository.currentUserSetting,
      methodName: 'resetAll',
      className: 'Discount Filter ${ErrorText.repositoryKey}',
    );
  }

  /// Filters the given list of discount items based on the activity filters.
  ///
  /// Only items that contain all filters in the cosen list.
  @override
  Either<SomeFailure, List<DiscountModel>> getFilterList(
    List<DiscountModel> unmodifiedDiscountModelItems,
  ) {
    return eitherHelper(
      () {
        if (!hasActivityItem) {
          return Right(unmodifiedDiscountModelItems);
        }
        final filterList = <DiscountModel>[];

        for (final discount in unmodifiedDiscountModelItems) {
          if (_FilterEnum.values.every(
            (filterEnum) => _activityListContainAnyValuesWithFilterEnum(
              filterEnum: filterEnum,
              discount: discount,
              // callMethodName: 'getFilterList',
            ),
          )) {
            filterList.add(discount);
          }
        }

        return Right(filterList);
      },
      user: _DiscountFilterRepository._userRepository.currentUser,
      userSetting: _DiscountFilterRepository._userRepository.currentUserSetting,
      methodName: 'getFilterList',
      className: 'Discount Filter ${ErrorText.repositoryKey}',
    );
  }

  /// Saves the current active filter state. The saved state can be reverted
  /// using the [revertActiveFilter] method.
  @override
  Either<SomeFailure, bool> saveActiveFilter() {
    return eitherHelper(
      () {
        _mobSaveActiveEligibilityMap
          ..clear()
          ..addAll(_activeEligibilityMap);
        _mobSaveActiveCategoryMap
          ..clear()
          ..addAll(_activeCategoryMap);
        _mobSaveActiveLocationMap
          ..clear()
          ..addAll(_activeLocationMap);
        return const Right(true);
      },
      user: _DiscountFilterRepository._userRepository.currentUser,
      userSetting: _DiscountFilterRepository._userRepository.currentUserSetting,
      methodName: 'saveActiveFilter',
      className: 'Discount Filter ${ErrorText.repositoryKey}',
    );
  }

  /// Reverts the current active filter to the previously saved state using
  /// the [saveActiveFilter] method.
  @override
  Either<SomeFailure, bool> revertActiveFilter(
    List<DiscountModel> unmodifiedDiscountModelItems,
  ) {
    return eitherHelper(
      () {
        _activeEligibilityMap
          ..clear()
          ..addAll(_mobSaveActiveEligibilityMap);
        _activeCategoryMap
          ..clear()
          ..addAll(_mobSaveActiveCategoryMap);
        _activeLocationMap
          ..clear()
          ..addAll(_mobSaveActiveLocationMap);
        return getFilterValuesFromDiscountItems(
          unmodifiedDiscountModelItems,
        );
      },
      user: _DiscountFilterRepository._userRepository.currentUser,
      userSetting: _DiscountFilterRepository._userRepository.currentUserSetting,
      methodName: 'saveActiveFilter',
      className: 'Discount Filter ${ErrorText.repositoryKey}',
    );
  }

  /// Set new values to map from List<DiscountModel>
  @override
  Either<SomeFailure, bool> getFilterValuesFromDiscountItems(
    List<DiscountModel> unmodifiedDiscountModelItems,
  ) {
    return eitherHelper(
      () {
        _eligibilityMap.clear();
        _categoryMap.clear();
        _locationSearchMap.clear();
        _locationMap.clear();

        final categoriesList = <TranslateModel>[];
        final locationList = <TranslateModel>[];
        final eligibilitiesList = <EligibilityEnum>[];

        // Add all categories, location and eligibilities: Start
        // item in the list can contain the same values.
        // It'll fix in the _getFilterFromTranslateModel method
        for (final discount in unmodifiedDiscountModelItems) {
          // Category
          categoriesList.addAll(discount.category);

          // Location
          if (discount.location != null) {
            locationList.addAll(discount.location!);
          }
          if (discount.subLocation != null) {
            locationList.add(KAppText.sublocation);
          }

          // Eligibility
          if (discount.eligibility.contains(EligibilityEnum.all)) {
            eligibilitiesList.addAll(EligibilityEnum.valuesWithoutAll);
          } else {
            eligibilitiesList.addAll(discount.eligibility);
          }
        }
        // Add all categories, location and eligibilities: End

        Left<SomeFailure, bool>? failure;

        // Category. Start:
        failure = _getFilterFromTranslateModel(
          list: categoriesList,
          activityMap: _activeCategoryMap,
          // callMethodName: 'getFilterValuesFromDiscountItems',
        ).fold(
          Left.new,
          (r) {
            _categoryMap.addAll(r);
            return failure;
          },
        );

        _addActivityMapToItemsMap(
          activityMap: _activeCategoryMap,
          itemsMap: _categoryMap,
          // callMethodName: 'getFilterValuesFromDiscountItems',
        );
        // Category. End:

        //Location. Start:
        failure = _getLocationFilterFromTranslateModel(
          list: locationList,
          activityMap: _activeLocationMap,
          // callMethodName: 'getFilterValuesFromDiscountItems',
        ).fold(
          Left.new,
          (r) {
            _locationMap.addAll(r);
            return failure;
          },
        );

        _addActivityMapToItemsMap(
          activityMap: _activeLocationMap,
          itemsMap: _locationMap,
          // callMethodName: 'getFilterValuesFromDiscountItems',
        );
        _locationSearchMap.addAll(_locationMap);
        //Location. End.

        // Eligibility. Start:
        failure = _getFilterFromTranslateModel(
          list: eligibilitiesList.getTranslateModels,
          activityMap: _activeEligibilityMap,
          // callMethodName: 'getFilterValuesFromDiscountItems',
        ).fold(
          Left.new,
          (r) {
            _eligibilityMap.addAll(r);
            return failure;
          },
        );

        _addActivityMapToItemsMap(
          activityMap: _activeEligibilityMap,
          itemsMap: _eligibilityMap,
          // callMethodName: 'getFilterValuesFromDiscountItems',
        );

        return failure ?? const Right(true);
      },
      user: _DiscountFilterRepository._userRepository.currentUser,
      userSetting: _DiscountFilterRepository._userRepository.currentUserSetting,
      methodName: 'getFilterValuesFromDiscountItems',
      className: 'Discount Filter ${ErrorText.repositoryKey}',
    );
  }
}
