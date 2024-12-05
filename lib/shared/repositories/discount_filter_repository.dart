import 'package:collection/collection.dart';
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
  /// Constructor to initialize an empty maps.
  const DiscountFilterRepository.empty()
      : _locationMap = const {},
        _categoryMap = const {},
        _activeCategoryMap = const {},
        _locationSearchMap = const {},
        _activeLocationMap = const {},
        _eligibilityMap = const {},
        _activeEligibilityMap = const {};

  /// Constructor to initialize maps.
  DiscountFilterRepository.init({
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  })  : _categoryMap = {},
        _activeCategoryMap = {},
        _locationMap = {},
        _locationSearchMap = {},
        _activeLocationMap = {},
        _eligibilityMap = {},
        _activeEligibilityMap = {} {
    getFilterValuesFromDiscountItems(
      unmodifiedDiscountModelItems: unmodifiedDiscountModelItems,
      isEnglish: isEnglish,
    );
  }

  // Maps to store current available filters
  final Map<String, FilterItem> _eligibilityMap;
  final Map<String, FilterItem> _categoryMap;
  final Map<String, FilterItem> _locationSearchMap;

  // Maps to store current selected user filters
  final Map<String, FilterItem> _activeEligibilityMap;
  final Map<String, FilterItem> _activeCategoryMap;
  final Map<String, FilterItem> _activeLocationMap;

  final Map<String, FilterItem> _locationMap;
  static var _locationSearchValue = '';

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

  /// Combines all activity filters into a single map.
  @override
  Map<String, FilterItem> get getActivityList => {
        ..._activeEligibilityMap,
        ..._activeCategoryMap,
        ..._activeLocationMap,
      };

  /// Set new values to map from List<DiscountModel>
  @override
  void getFilterValuesFromDiscountItems({
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  }) {
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
        if (discount.eligibility != null) {
          eligibilitiesList.addAll(discount.eligibility!);
        }
      }
      // Add all categories, location and eligibilities: End

      _categoryMap.addAll(
        _getFilterFromTranslateModel(
          list: categoriesList,
          activityMap: _activeCategoryMap,
        ),
      );
      _addActivityMapToItemsMap(
        activityMap: _activeCategoryMap,
        itemsMap: _categoryMap,
      );
      //Location. Start:
      _locationMap.addAll(
        _sortingLocation(
          locationMap: _getFilterFromTranslateModel(
            list: locationList,
            activityMap: _activeLocationMap,
          ),
          isEnglish: isEnglish,
        ),
      );

      if (_activeLocationMap.isEmpty &&
          _locationMap.containsKey(KAppText.sublocation.uk)) {
        _activeLocationMap.addAll({
          KAppText.sublocation.uk: _locationMap[KAppText.sublocation.uk]!,
        });
      }

      _addActivityMapToItemsMap(
        activityMap: _activeLocationMap,
        itemsMap: _locationMap,
      );
      _locationSearchMap.addAll(_locationMap);
      //Location. End.

      _eligibilityMap.addAll(
        _getFilterFromTranslateModel(
          list: eligibilitiesList.getTranslateModels,
          activityMap: _activeEligibilityMap,
        ),
      );
      _addActivityMapToItemsMap(
        activityMap: _activeEligibilityMap,
        itemsMap: _eligibilityMap,
      );
    } catch (e) {
      // TODO: add error handling
    }
  }

  /// Toggles an existing category filter.
  /// Updates the activity categories filter
  /// and available filter lists accordingly.
  @override
  void addCategory({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  }) {
    _addFilterItem(
      valueUK: valueUK,
      filter: _categoryMap,
      activityFilter: _activeCategoryMap,
      unmodifiedDiscountModelItems: unmodifiedDiscountModelItems,
      filterEnum: _FilterEnum.category,
    );
  }

  /// Toggles an existing location filter.
  /// Updates the activity location filter and available filter
  /// lists accordingly.
  @override
  void addLocation({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  }) {
    _addFilterItem(
      valueUK: valueUK,
      filter: _locationMap,
      activityFilter: _activeLocationMap,
      unmodifiedDiscountModelItems: unmodifiedDiscountModelItems,
      filterEnum: _FilterEnum.location,
    );
  }

  /// Toggles an existing eligibilities filter.
  /// Updates the activity eligibilities
  /// filter and available filter lists accordingly.
  @override
  void addEligibility({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  }) {
    _addFilterItem(
      valueUK: valueUK,
      filter: _eligibilityMap,
      activityFilter: _activeEligibilityMap,
      unmodifiedDiscountModelItems: unmodifiedDiscountModelItems,
      filterEnum: _FilterEnum.eligibility,
    );
  }

  /// Serch location value in the location map.
  /// Search value in the uk and en values
  @override
  void locationSearch(String? value) {
    if (value != null) {
      _locationSearchValue = value;
    }

    _locationSearchMap.clear();

    if (_locationSearchValue.isEmpty) {
      _locationSearchMap.addAll(_locationMap);
    } else {
      for (final key in _locationMap.keys.where(
        (element) => element.toLowerCase().startsWith(_locationSearchValue),
      )) {
        _locationSearchMap.addAll({key: _locationMap[key]!});
      }
    }
  }

  /// Clear values in the activity map
  @override
  void resetAll({
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  }) {
    _activeCategoryMap.clear();
    _activeEligibilityMap.clear();
    _activeLocationMap.clear();

    getFilterValuesFromDiscountItems(
      unmodifiedDiscountModelItems: unmodifiedDiscountModelItems,
      isEnglish: isEnglish,
    );
  }

  /// Filters the given list of discount items based on the activity filters.
  ///
  /// Only items that contain all filters in the cosen list.
  @override
  List<DiscountModel> getFilterList(
    List<DiscountModel> unmodifiedDiscountModelItems,
  ) {
    final filterList = <DiscountModel>[];

    for (final discount in unmodifiedDiscountModelItems) {
      if (_FilterEnum.values.every(
        (filterEnum) => _activityListContainAnyValuesWithFilterEnum(
          filterEnum: filterEnum,
          discount: discount,
        ),
      )) {
        filterList.add(discount);
      }
    }

    return filterList;
  }

  void _addFilterItem({
    required String valueUK,
    required Map<String, FilterItem> filter,
    required Map<String, FilterItem> activityFilter,
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required _FilterEnum filterEnum,
  }) {
    // Add New Filter Item To activity List and Change Is Selected For Item With
    // Value ValueUK: Start
    final value = filter[valueUK];
    final filterItem = value?.copyWith(isSelected: !value.isSelected) ??
        FilterItem(
          TranslateModel(uk: valueUK),
        );
    if (!activityFilter.containsKey(valueUK)) {
      activityFilter[valueUK] = filterItem;
    } else {
      activityFilter.remove(valueUK);
    }
    filter[valueUK] = filterItem;
    // Add New Filter Item To activity List and Change Is Selected For Item With
    // Value ValueUK: End

    // Change two another filter list: Start
    final eligibilitiesList = <TranslateModel>[];
    final locationList = <TranslateModel>[];
    final categoriesList = <TranslateModel>[];

    for (final discount in unmodifiedDiscountModelItems) {
      if (_activityListContainAnyValuesWithFilterEnum(
        filterEnum: filterEnum,
        discount: discount,
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
        )) {
          if (discount.eligibility != null) {
            eligibilitiesList.addAll(discount.eligibility!.getTranslateModels);
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
        )) {
          if (discount.eligibility != null) {
            categoriesList.addAll(discount.category);
          }
        }
      }
    }

    // Romve prevoius value from filter Eligibilities and set new value
    if (filterEnum != _FilterEnum.eligibility) {
      _eligibilityMap
        ..clear()
        ..addAll(
          _getFilterFromTranslateModel(
            list: eligibilitiesList,
            activityMap: _activeEligibilityMap,
          ),
        );
    }

    // Romve prevoius value from filter Location and set new value
    if (filterEnum != _FilterEnum.location) {
      _locationMap
        ..clear()
        ..addAll(
          _getFilterFromTranslateModel(
            list: locationList,
            activityMap: _activeLocationMap,
          ),
        );
    }

    // Romve prevoius value from filter Categories and set new value
    if (filterEnum != _FilterEnum.category) {
      _categoryMap
        ..clear()
        ..addAll(
          _getFilterFromTranslateModel(
            list: categoriesList,
            activityMap: _activeCategoryMap,
          ),
        );
    }
    // Change two another filter list: End

    locationSearch(null);
  }

  void _addActivityMapToItemsMap({
    required Map<String, FilterItem> activityMap,
    required Map<String, FilterItem> itemsMap,
  }) {
    if (activityMap.isNotEmpty) {
      for (final key in activityMap.keys) {
        if (itemsMap.containsKey(key)) {
          itemsMap[key] = itemsMap[key]!.copyWith(isSelected: true);
        }
      }
    }
  }

  /// Helper to check if discount contain value from activity list.
  /// discount field and activity filter set use filterEnum
  bool _activityListContainAnyValuesWithFilterEnum({
    required _FilterEnum filterEnum,
    required DiscountModel discount,
  }) {
    switch (filterEnum) {
      case _FilterEnum.category:
        return _activityListContainAnyValues(
          values: discount.category,
          activityFilter: _activeCategoryMap,
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
        );
      case _FilterEnum.eligibility:
        return _activityListContainAnyValues(
          values: discount.eligibility?.getTranslateModels,
          activityFilter: _activeEligibilityMap,
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
  }) {
    if (activityFilter.isEmpty) {
      return true;
    } else if (values == null) {
      return false;
    } else {
      return values.any((value) => activityFilter.containsKey(value.uk));
    }
  }

  /// Create Map<String, FilterItem> from List<TranslateModel>
  /// set is selected true for element where value.uk contain activity map
  Map<String, FilterItem> _getFilterFromTranslateModel({
    required List<TranslateModel> list,
    required Map<String, FilterItem> activityMap,
  }) {
    // Create map where key is not repeat value(uk) and values
    // contain how main another element in the list contain the same value
    final groupList = groupBy(
      list,
      (value) => value.uk,
    );

    final filters = <String, FilterItem>{};

    // sorted key list use how many values the in the groupList
    // Sorting in descending order
    final keysSorted = groupList.keys.sorted(
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
    return filters;
  }

  /// Sorting location
  /// First five value sorting by number
  /// After first five value sorting by alphabet
  /// Language for alphabet sorting set use isEnglish
  Map<String, FilterItem> _sortingLocation({
    required Map<String, FilterItem> locationMap,
    required bool isEnglish,
  }) {
    final locationEntries = locationMap.entries;
    return Map.fromEntries(
      [
        // not srting first five value because when get value
        // from _getFilterFromTranslateModel it sorting by number
        ...locationEntries.take(KDimensions.discountLocationNumberSortedItems),
        // sorting by alphabet all item after first five
        ...locationEntries
            .skip(KDimensions.discountLocationNumberSortedItems)
            .sorted(
          (a, b) {
            if (isEnglish && a.value.value.en != null) {
              // sorting by english alphabet if isEnglish and item
              // contain english value
              return a.value.value.en!
                  .compareTo(b.value.value.en.toString().toLowerCase());
            } else {
              // sorting by ukrain aphabet
              return a.value.value.uk.compareUkrain(b.value.value.uk);
            }
          },
        ),
      ],
    );
  }
}

enum _FilterEnum {
  category,
  eligibility,
  location,
}
