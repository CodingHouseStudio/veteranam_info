import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared_dart.dart';

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
class DiscountFilterRepository implements IDiscountFilterRepository {
  /// Constructor to initialize maps.
  DiscountFilterRepository.init()
      : _locationMap = {},
        _categoryMap = {},
        _activeCategoryMap = {},
        _mobSaveActiveCategoryMap = {},
        _locationSearchMap = {},
        _activeLocationMap = {},
        _mobSaveActiveLocationMap = {},
        _eligibilityMap = {},
        _activeEligibilityMap = {},
        _mobSaveActiveEligibilityMap = {},
        _mapEquality = const MapEquality();

  /// Constructor to initialize an empty maps.
  const DiscountFilterRepository.empty()
      : _locationMap = const {},
        _categoryMap = const {},
        _activeCategoryMap = const {},
        _mobSaveActiveCategoryMap = const {},
        _locationSearchMap = const {},
        _activeLocationMap = const {},
        _mobSaveActiveLocationMap = const {},
        _eligibilityMap = const {},
        _activeEligibilityMap = const {},
        _mobSaveActiveEligibilityMap = const {},
        _mapEquality = const MapEquality();

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
  final Map<String, FilterItem> _eligibilityMap;
  final Map<String, FilterItem> _categoryMap;
  final Map<String, FilterItem> _locationSearchMap;

  // Maps to store current selected user filters
  final Map<String, FilterItem> _activeEligibilityMap;
  final Map<String, FilterItem> _activeCategoryMap;
  final Map<String, FilterItem> _activeLocationMap;

  // Maps to store current selected mobile filters
  final Map<String, FilterItem> _mobSaveActiveEligibilityMap;
  final Map<String, FilterItem> _mobSaveActiveCategoryMap;
  final Map<String, FilterItem> _mobSaveActiveLocationMap;

  final Map<String, FilterItem> _locationMap;
  static var _locationSearchValue = '';
  final MapEquality<String, FilterItem> _mapEquality;

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

  // static SomeFailure? initError;
  static final UserRepository _userRepository = GetIt.I.get<UserRepository>();

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
  Either<SomeFailure, bool> addCategory({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
  }) {
    return _addFilterItem(
      valueUK: valueUK,
      filter: _categoryMap,
      activityFilter: _activeCategoryMap,
      unmodifiedDiscountModelItems: unmodifiedDiscountModelItems,
      filterEnum: _FilterEnum.category,
      callMethodName: 'addCategory',
    );
  }

  /// Toggles an existing location filter.
  /// Updates the activity location filter and available filter
  /// lists accordingly.
  @override
  Either<SomeFailure, bool> addLocation({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
  }) {
    return _addFilterItem(
      valueUK: valueUK,
      filter: _locationMap,
      activityFilter: _activeLocationMap,
      unmodifiedDiscountModelItems: unmodifiedDiscountModelItems,
      filterEnum: _FilterEnum.location,
      callMethodName: 'addLocation',
    );
  }

  /// Toggles an existing eligibilities filter.
  /// Updates the activity eligibilities
  /// filter and available filter lists accordingly.
  @override
  Either<SomeFailure, bool> addEligibility({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
  }) {
    return _addFilterItem(
      valueUK: valueUK,
      filter: _eligibilityMap,
      activityFilter: _activeEligibilityMap,
      unmodifiedDiscountModelItems: unmodifiedDiscountModelItems,
      filterEnum: _FilterEnum.eligibility,
      callMethodName: 'addEligibility',
    );
  }

  /// Serch location value in the location map.
  /// Search value in the uk and en values
  @override
  Either<SomeFailure, bool> locationSearch(String? value) {
    try {
      if (value != null) {
        _locationSearchValue = value.toLowerCase();
      }

      _locationSearchMap.clear();

      if (_locationSearchValue.isEmpty) {
        _locationSearchMap.addAll(_locationMap);
      } else {
        final filterList = _locationMap.values.where(
          (element) =>
              element.value.uk.toLowerCase().startsWith(_locationSearchValue) ||
              (element.value.en
                      ?.toLowerCase()
                      .startsWith(_locationSearchValue) ??
                  false),
        );
        for (final value in filterList) {
          final key = value.value.uk;
          _locationSearchMap.addAll({key: _locationMap[key]!});
        }
      }
      return const Right(true);
    } catch (e, stack) {
      return Left(
        SomeFailure.filter(
          error: e,
          stack: stack,
          user: _userRepository.currentUser,
          userSetting: _userRepository.currentUserSetting,
          data: value,
          tag: 'locationSearch',
          tagKey: 'Discount Filter ${ErrorText.repositoryKey}',
        ),
      );
    }
  }

  /// Clear values in the activity map
  @override
  Either<SomeFailure, bool> resetAll(
    List<DiscountModel> unmodifiedDiscountModelItems,
  ) {
    _activeCategoryMap.clear();
    _activeEligibilityMap.clear();
    _activeLocationMap.clear();

    return getFilterValuesFromDiscountItems(
      unmodifiedDiscountModelItems,
    );
  }

  /// Filters the given list of discount items based on the activity filters.
  ///
  /// Only items that contain all filters in the cosen list.
  @override
  Either<SomeFailure, List<DiscountModel>> getFilterList(
    List<DiscountModel> unmodifiedDiscountModelItems,
  ) {
    try {
      final filterList = <DiscountModel>[];

      for (final discount in unmodifiedDiscountModelItems) {
        if (_FilterEnum.values.every(
          (filterEnum) => _activityListContainAnyValuesWithFilterEnum(
            filterEnum: filterEnum,
            discount: discount,
            callMethodName: 'getFilterList',
          ),
        )) {
          filterList.add(discount);
        }
      }

      return Right(filterList);
    } catch (e, stack) {
      return Left(
        SomeFailure.filter(
          error: e,
          stack: stack,
          user: _userRepository.currentUser,
          userSetting: _userRepository.currentUserSetting,
          tag: 'getFilterList',
          tagKey: 'Discount Filter ${ErrorText.repositoryKey}',
        ),
      );
    }
  }

  /// Saves the current active filter state. The saved state can be reverted
  /// using the [revertActiveFilter] method.
  @override
  Either<SomeFailure, bool> saveActiveFilter() {
    try {
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
    } catch (e, stack) {
      return Left(
        SomeFailure.filter(
          error: e,
          stack: stack,
          user: _userRepository.currentUser,
          userSetting: _userRepository.currentUserSetting,
          tag: 'saveActiveFilter',
          tagKey: 'Discount Filter ${ErrorText.repositoryKey}',
        ),
      );
    }
  }

  /// Reverts the current active filter to the previously saved state using
  /// the [saveActiveFilter] method.
  @override
  Either<SomeFailure, bool> revertActiveFilter(
    List<DiscountModel> unmodifiedDiscountModelItems,
  ) {
    try {
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
    } catch (e, stack) {
      return Left(
        SomeFailure.filter(
          error: e,
          stack: stack,
          user: _userRepository.currentUser,
          userSetting: _userRepository.currentUserSetting,
          tag: 'saveActiveFilter',
          tagKey: 'Discount Filter ${ErrorText.repositoryKey}',
        ),
      );
    }
  }

  /// Set new values to map from List<DiscountModel>
  @override
  Either<SomeFailure, bool> getFilterValuesFromDiscountItems(
    List<DiscountModel> unmodifiedDiscountModelItems,
  ) {
    try {
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

      SomeFailure? failure;

      // Category. Start:
      _getFilterFromTranslateModel(
        list: categoriesList,
        activityMap: _activeCategoryMap,
        callMethodName: 'getFilterValuesFromDiscountItems',
      ).fold(
        (l) => failure = l,
        _categoryMap.addAll,
      );

      _addActivityMapToItemsMap(
        activityMap: _activeCategoryMap,
        itemsMap: _categoryMap,
        callMethodName: 'getFilterValuesFromDiscountItems',
      );
      // Category. End:

      //Location. Start:
      _getLocationFilterFromTranslateModel(
        list: locationList,
        activityMap: _activeLocationMap,
        callMethodName: 'getFilterValuesFromDiscountItems',
      ).fold(
        (l) => failure = l,
        _locationMap.addAll,
      );

      _addActivityMapToItemsMap(
        activityMap: _activeLocationMap,
        itemsMap: _locationMap,
        callMethodName: 'getFilterValuesFromDiscountItems',
      );
      _locationSearchMap.addAll(_locationMap);
      //Location. End.

      // Eligibility. Start:
      _getFilterFromTranslateModel(
        list: eligibilitiesList.getTranslateModels,
        activityMap: _activeEligibilityMap,
        callMethodName: 'getFilterValuesFromDiscountItems',
      ).fold((l) => failure = l, _eligibilityMap.addAll);

      _addActivityMapToItemsMap(
        activityMap: _activeEligibilityMap,
        itemsMap: _eligibilityMap,
        callMethodName: 'getFilterValuesFromDiscountItems',
      );

      // Eligibility. End:
      if (failure != null) return Left(failure!);

      return const Right(true);
    } catch (e, stack) {
      return Left(
        SomeFailure.filter(
          error: e,
          stack: stack,
          user: _userRepository.currentUser,
          userSetting: _userRepository.currentUserSetting,
          tag: 'getFilterValuesFromDiscountItems',
          tagKey: 'Discount Filter ${ErrorText.repositoryKey}',
        ),
      );
    }
  }

  Either<SomeFailure, bool> _addFilterItem({
    required String valueUK,
    required Map<String, FilterItem> filter,
    required Map<String, FilterItem> activityFilter,
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required _FilterEnum filterEnum,
    required String callMethodName,
  }) {
    try {
      // Add New Filter Item To activity List and Change Is Selected For
      // Item With
      // Value ValueUK: Start
      final value = filter[valueUK];
      final filterItem = value?.copyWith(isSelected: !value.isSelected) ??
          FilterItem(
            TranslateModel(uk: valueUK),
          );
      if (!activityFilter.containsKey(valueUK)) {
        // One Item Code Start:
        for (final key in activityFilter.keys) {
          filter[key] = filter[key]!.copyWith(isSelected: false);
        }
        activityFilter.clear();
        // One Item Code End:
        activityFilter[valueUK] = filterItem;
      } else {
        activityFilter.remove(valueUK);
      }
      filter[valueUK] = filterItem;
      // Add New Filter Item To activity List and Change Is Selected For Item
      // With
      // Value ValueUK: End

      // Change two another filter list: Start
      final eligibilitiesList = <TranslateModel>[];
      final locationList = <TranslateModel>[];
      final categoriesList = <TranslateModel>[];

      for (final discount in unmodifiedDiscountModelItems) {
        if (_activityListContainAnyValuesWithFilterEnum(
          filterEnum: filterEnum,
          discount: discount,
          callMethodName: callMethodName,
        )) {
          // Add Eligibility
          // discount contain category and call from add Location method
          // OR
          // discount contain location and call from add Category method
          if (_activityListContainAnyValuesWithFilterEnum(
            filterEnum: filterEnum == _FilterEnum.category
                ? _FilterEnum.location
                : _FilterEnum.category,
            discount: discount,
            callMethodName: callMethodName,
          )) {
            if (discount.eligibility.contains(EligibilityEnum.all)) {
              eligibilitiesList
                  .addAll(EligibilityEnum.valuesWithoutAll.getTranslateModels);
            } else {
              eligibilitiesList.addAll(discount.eligibility.getTranslateModels);
            }
          }

          // Add Location
          // discount contain category and call from add Eligibility method
          // OR
          // discount contain eligibility and call from add Category method
          if (_activityListContainAnyValuesWithFilterEnum(
            filterEnum: filterEnum == _FilterEnum.category
                ? _FilterEnum.eligibility
                : _FilterEnum.category,
            discount: discount,
            callMethodName: callMethodName,
          )) {
            if (discount.location != null) {
              locationList.addAll(discount.location!);
            }
            if (discount.subLocation != null) {
              locationList.add(KAppText.sublocation);
            }
          }

          // Add Category
          // discount contain location and call from add Eligibility method
          // OR
          // discount contain dligibility and call from add Location method
          if (_activityListContainAnyValuesWithFilterEnum(
            filterEnum: filterEnum == _FilterEnum.location
                ? _FilterEnum.eligibility
                : _FilterEnum.location,
            discount: discount,
            callMethodName: callMethodName,
          )) {
            categoriesList.addAll(discount.category);
          }
        }
      }

      SomeFailure? failure;

      // Romve prevoius value from filter Eligibilities and set new value
      if (filterEnum != _FilterEnum.eligibility) {
        _getFilterFromTranslateModel(
          list: eligibilitiesList,
          activityMap: _activeEligibilityMap,
          callMethodName: callMethodName,
        ).fold(
          (l) => failure = l,
          (r) => _eligibilityMap
            ..clear()
            ..addAll(
              r,
            ),
        );
      }

      // Romve prevoius value from filter Location and set new value
      if (filterEnum != _FilterEnum.location) {
        _getLocationFilterFromTranslateModel(
          list: locationList,
          activityMap: _activeLocationMap,
          callMethodName: callMethodName,
        ).fold(
          (l) => failure = l,
          (r) => _locationMap
            ..clear()
            ..addAll(
              r,
            ),
        );
      }

      // Romve prevoius value from filter Categories and set new value
      if (filterEnum != _FilterEnum.category) {
        _getFilterFromTranslateModel(
          list: categoriesList,
          activityMap: _activeCategoryMap,
          callMethodName: callMethodName,
        ).fold(
          (l) => failure = l,
          (r) => _categoryMap
            ..clear()
            ..addAll(
              r,
            ),
        );
      }
      // Change two another filter list: End

      locationSearch(null).fold((l) => failure = l, Right.new);

      if (failure != null) return Left(failure!);

      return const Right(true);
    } catch (e, stack) {
      return Left(
        SomeFailure.filter(
          error: e,
          stack: stack,
          user: _userRepository.currentUser,
          userSetting: _userRepository.currentUserSetting,
          data: 'valueUK: $valueUK | activityFilter: $activityFilter '
              '| filterEnum: $filterEnum',
          tag: '_addFilterItem',
          tagKey: 'Discount Filter ${ErrorText.repositoryKey}',
          tag2Key: ErrorText.callFrom,
          tag2: callMethodName,
        ),
      );
    }
  }

  Either<SomeFailure, bool> _addActivityMapToItemsMap({
    required Map<String, FilterItem> activityMap,
    required Map<String, FilterItem> itemsMap,
    required String callMethodName,
  }) {
    try {
      if (activityMap.isNotEmpty) {
        for (final key in activityMap.keys) {
          if (itemsMap.containsKey(key)) {
            itemsMap[key] = itemsMap[key]!.copyWith(isSelected: true);
          }
        }
      }
      return const Right(true);
    } catch (e, stack) {
      return Left(
        SomeFailure.filter(
          error: e,
          stack: stack,
          user: _userRepository.currentUser,
          userSetting: _userRepository.currentUserSetting,
          data: 'activityMap: $activityMap',
          tag: '_addActivityMapToItemsMap',
          tagKey: 'Discount Filter ${ErrorText.repositoryKey}',
          tag2Key: ErrorText.callFrom,
          tag2: callMethodName,
        ),
      );
    }
  }

  /// Helper to check if discount contain value from activity list.
  /// discount field and activity filter set use filterEnum
  bool _activityListContainAnyValuesWithFilterEnum({
    required _FilterEnum filterEnum,
    required DiscountModel discount,
    required String callMethodName,
  }) {
    switch (filterEnum) {
      case _FilterEnum.category:
        return _activityListContainAnyValues(
          values: discount.category,
          activityFilter: _activeCategoryMap,
          callMethodName: callMethodName,
        );
      case _FilterEnum.location:
        return _activityListContainAnyValues(
          values: discount.subLocation == null
              ? discount.location
              : [
                  if (discount.location != null) ...discount.location!,
                  if (discount.subLocation != null) KAppText.sublocation,
                ],
          activityFilter: _activeLocationMap,
          callMethodName: callMethodName,
        );
      case _FilterEnum.eligibility:
        return _activityListContainAnyValues(
          values: discount.eligibility.getTranslateModels,
          activityFilter: _activeEligibilityMap,
          callMethodName: callMethodName,
        );
    }
  }

  /// Checks if activity filter list contain translate model list.
  ///
  /// return true if activity list empty
  ///
  /// return false if activity list is not empty and translate model list is
  /// null
  ///
  /// return true/false if activity list is not empty, translate model list is not null
  /// and if translate model list(uk value) contain every keys
  bool _activityListContainAnyValues({
    required List<TranslateModel>? values,
    required Map<String, FilterItem> activityFilter,
    required String callMethodName,
  }) {
    try {
      if (activityFilter.isEmpty) {
        return true;
      } else if (values == null) {
        return false;
      } else {
        return values.any(
          (value) =>
              activityFilter.containsKey(value.uk) ||
              value.uk == KAppText.eligibilityAllUA,
        );
      }
    } catch (e, stack) {
      SomeFailure.filter(
        error: e,
        stack: stack,
        user: _userRepository.currentUser,
        userSetting: _userRepository.currentUserSetting,
        data: 'activityFilter: $activityFilter',
        tag: '_activityListContainAnyValues',
        tagKey: 'Discount Filter ${ErrorText.repositoryKey}',
        tag2Key: ErrorText.callFrom,
        tag2: callMethodName,
      );
      return true;
    }
  }

  /// Create Map<String, FilterItem> from List<TranslateModel>
  /// set is selected true for element where value.uk contain activity map
  Either<SomeFailure, Map<String, FilterItem>> _getFilterFromTranslateModel({
    required List<TranslateModel> list,
    required Map<String, FilterItem> activityMap,
    required String callMethodName,
    List<String> Function(Map<String, List<TranslateModel>> list)?
        sortingMethod,
  }) {
    try {
      // Create map where key is not repeat value(uk) and values
      // contain how main another element in the list contain the same value
      final groupList = groupBy(
        list,
        (value) => value.uk,
      );

      final filters = <String, FilterItem>{};

      // sorted key list use how many values the in the groupList
      // Sorting in descending order
      final keysSorted = sortingMethod?.call(groupList) ??
          groupList.keys.sorted(
            (a, b) => groupList[b]!.length.compareTo(
                  groupList[a]!.length,
                ),
          );

      // Create Filter Item map use group list
      // values set use first value from map with the same values
      // number set how many the same values contain group list
      // set is selected true if activityMap contain value.uk/key
      for (final key in keysSorted) {
        filters.addAll({
          key: FilterItem(
            groupList[key]!.first,
            number: groupList[key]?.length ?? 1,
            isSelected: activityMap.containsKey(key),
          ),
        });
      }
      return Right(filters);
    } catch (e, stack) {
      return Left(
        SomeFailure.filter(
          error: e,
          stack: stack,
          user: _userRepository.currentUser,
          userSetting: _userRepository.currentUserSetting,
          data: 'activityMap: $activityMap',
          tag: '_getFilterFromTranslateModel',
          tagKey: 'Discount Filter ${ErrorText.repositoryKey}',
          tag2Key: ErrorText.callFrom,
          tag2: callMethodName,
        ),
      );
    }
  }

  /// Sorting location
  /// First five value sorting by number
  /// After first five value sorting by alphabet
  /// Language for alphabet sorting set use isEnglish
  Either<SomeFailure, Map<String, FilterItem>>
      _getLocationFilterFromTranslateModel({
    required List<TranslateModel> list,
    required Map<String, FilterItem> activityMap,
    required String callMethodName,
  }) {
    return _getFilterFromTranslateModel(
      list: list,
      activityMap: activityMap,
      callMethodName: callMethodName,
      sortingMethod: (groupList) {
        // not srting first five value because when get value
        // from _getFilterFromTranslateModel it sorting by number
        final numberSortList = groupList.keys.sorted(
          (a, b) => groupList[b]!.length.compareTo(
                groupList[a]!.length,
              ),
        );
        // sorting by alphabet all item after first five
        final alphabetSortList = numberSortList
            .skip(KDimensions.discountLocationNumberSortedItems)
            .sorted(
          (a, b) {
            if (a.isEmpty) return 0;
            if (b.isEmpty) return 1;
            if (_userRepository.isEnglish && groupList[a]!.first.en != null) {
              // sorting by english alphabet if isEnglish and item
              // contain english value
              return groupList[a]!
                  .first
                  .en!
                  .compareTo(groupList[b]!.first.en.toString().toLowerCase());
            } else {
              // sorting by ukrain aphabet
              return groupList[a]!
                  .first
                  .uk
                  .compareUkrain(groupList[b]!.first.uk);
            }
          },
        );
        final sortList = [
          ...numberSortList.take(KDimensions.discountLocationNumberSortedItems),
          ...alphabetSortList,
        ];
        if (sortList.remove(KAppText.sublocationUA)) {
          sortList.insert(0, KAppText.sublocationUA);
        }
        return sortList;
      },
    );
  }
}

enum _FilterEnum {
  category,
  eligibility,
  location,
}
