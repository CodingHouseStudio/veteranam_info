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
class FilterItemsModel {
  /// Constructor to initialize an empty maps.
  const FilterItemsModel.empty({
    this.categoryMap = const {},
    this.activeCategoryMap = const {},
    this.locationSearchMap = const {},
    this.activeLocationMap = const {},
    this.eligibilityMap = const {},
    this.activeEligibilityMap = const {},
  }) : _locationMap = const {};

  /// Constructor to initialize maps.
  FilterItemsModel.init({
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
    required Map<String, FilterItem> chosenCategories,
    required Map<String, FilterItem> chosenLocation,
    required Map<String, FilterItem> chosenEligibilities,
  })  : categoryMap = {},
        activeCategoryMap = {},
        _locationMap = {},
        locationSearchMap = {},
        activeLocationMap = {},
        eligibilityMap = {},
        activeEligibilityMap = {} {
    try {
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

      categoryMap.addAll(
        _getFilterFromTranslateModel(
          list: categoriesList,
          chosenMap: chosenCategories,
        ),
      );
      _addChosenMap(
        chosenMap: chosenCategories,
        currentChosenMap: activeCategoryMap,
        itemsMap: categoryMap,
      );
      //Location. Start:
      _locationMap.addAll(
        _sortingLocation(
          locationMap: _getFilterFromTranslateModel(
            list: locationList,
            chosenMap: chosenLocation,
          ),
          isEnglish: isEnglish,
        ),
      );
      _addChosenMap(
        chosenMap: chosenLocation.isEmpty &&
                _locationMap.containsKey(KAppText.sublocation.uk)
            ? {
                KAppText.sublocation.uk: _locationMap[KAppText.sublocation.uk]!,
              }
            : chosenLocation,
        currentChosenMap: activeLocationMap,
        itemsMap: _locationMap,
      );
      locationSearchMap.addAll(_locationMap);
      //Location. End.

      eligibilityMap.addAll(
        _getFilterFromTranslateModel(
          list: eligibilitiesList.getTranslateModels,
          chosenMap: chosenEligibilities,
        ),
      );
      _addChosenMap(
        chosenMap: chosenEligibilities,
        currentChosenMap: activeEligibilityMap,
        itemsMap: eligibilityMap,
      );
    } catch (e) {
      // TODO: add error handling
    }
  }

  // Maps to store current available filters
  final Map<String, FilterItem> eligibilityMap;
  final Map<String, FilterItem> categoryMap;
  final Map<String, FilterItem> locationSearchMap;

  // Maps to store current selected user filters
  final Map<String, FilterItem> activeEligibilityMap;
  final Map<String, FilterItem> activeCategoryMap;
  final Map<String, FilterItem> activeLocationMap;

  // private variables
  final Map<String, FilterItem> _locationMap;
  static var _locationSearchValue = '';

  /// Toggles an existing category filter.
  /// Updates the chosen categories filter
  /// and available filter lists accordingly.
  void addCategory({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  }) {
    _addFilterItem(
      valueUK: valueUK,
      filter: categoryMap,
      chosenFilter: activeCategoryMap,
      unmodifiedDiscountModelItems: unmodifiedDiscountModelItems,
      filterEnum: _FilterEnum.category,
    );
  }

  /// Toggles an existing location filter.
  /// Updates the chosen location filter and available filter lists accordingly.
  void addLocation({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  }) {
    _addFilterItem(
      valueUK: valueUK,
      filter: _locationMap,
      chosenFilter: activeLocationMap,
      unmodifiedDiscountModelItems: unmodifiedDiscountModelItems,
      filterEnum: _FilterEnum.location,
    );
  }

  /// Toggles an existing eligibilities filter.
  /// Updates the chosen eligibilities
  /// filter and available filter lists accordingly.
  void addEligibility({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  }) {
    _addFilterItem(
      valueUK: valueUK,
      filter: eligibilityMap,
      chosenFilter: activeEligibilityMap,
      unmodifiedDiscountModelItems: unmodifiedDiscountModelItems,
      filterEnum: _FilterEnum.eligibility,
    );
  }

  /// Serch location value in the location map.
  /// Search value in the uk and en values
  void locationSearch(String? value) {
    if (value != null) {
      _locationSearchValue = value;
    }

    locationSearchMap.clear();

    if (_locationSearchValue.isEmpty) {
      locationSearchMap.addAll(_locationMap);
    } else {
      for (final key in _locationMap.keys.where(
        (element) => element.toLowerCase().startsWith(_locationSearchValue),
      )) {
        locationSearchMap.addAll({key: _locationMap[key]!});
      }
    }
  }

  /// Filters the given list of discount items based on the chosen filters.
  ///
  /// Only items that contain all filters in the cosen list.
  List<DiscountModel> getFilterList(
    List<DiscountModel> unmodifiedDiscountModelItems,
  ) {
    final filterList = <DiscountModel>[];

    for (final discount in unmodifiedDiscountModelItems) {
      if (_FilterEnum.values.every(
        (filterEnum) => _chosenListContainAnyValuesWithFilterEnum(
          filterEnum: filterEnum,
          discount: discount,
        ),
      )) {
        filterList.add(discount);
      }
    }

    return filterList;
  }

  /// Checks if any filters are currently chosen in any dimension.
  bool get haschosenItem =>
      activeEligibilityMap.isNotEmpty ||
      activeCategoryMap.isNotEmpty | activeLocationMap.isNotEmpty;

  bool get locationIsNotEpmty => _locationMap.isNotEmpty;

  /// Combines all chosen filters into a single map.
  Map<String, FilterItem> get getchosenList => {
        ...activeEligibilityMap,
        ...activeCategoryMap,
        ...activeLocationMap,
      };

  void _addFilterItem({
    required String valueUK,
    required Map<String, FilterItem> filter,
    required Map<String, FilterItem> chosenFilter,
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required _FilterEnum filterEnum,
  }) {
    // Add New Filter Item To Chosen List and Change Is Selected For Item With
    // Value ValueUK: Start
    final value = filter[valueUK];
    final filterItem = value?.copyWith(isSelected: !value.isSelected) ??
        FilterItem(
          TranslateModel(uk: valueUK),
        );
    if (chosenFilter.containsKey(valueUK)) {
      chosenFilter[valueUK] = filterItem;
    } else {
      chosenFilter.remove(valueUK);
    }
    filter[valueUK] = filterItem;
    // Add New Filter Item To Chosen List and Change Is Selected For Item With
    // Value ValueUK: End

    // Change two another filter list: Start
    final eligibilitiesList = <TranslateModel>[];
    final locationList = <TranslateModel>[];
    final categoriesList = <TranslateModel>[];

    for (final discount in unmodifiedDiscountModelItems) {
      if (_chosenListContainAnyValuesWithFilterEnum(
        filterEnum: filterEnum,
        discount: discount,
      )) {
        // Add Eligibility
        // discount contain category and call from add Location method
        // OR
        // discount contain location and call from add Category method
        if (_chosenListContainAnyValuesWithFilterEnum(
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
        if (_chosenListContainAnyValuesWithFilterEnum(
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
        if (_chosenListContainAnyValuesWithFilterEnum(
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
      eligibilityMap
        ..clear()
        ..addAll(
          _getFilterFromTranslateModel(
            list: eligibilitiesList,
            chosenMap: activeEligibilityMap,
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
            chosenMap: activeLocationMap,
          ),
        );
    }

    // Romve prevoius value from filter Categories and set new value
    if (filterEnum != _FilterEnum.category) {
      categoryMap
        ..clear()
        ..addAll(
          _getFilterFromTranslateModel(
            list: categoriesList,
            chosenMap: activeCategoryMap,
          ),
        );
    }
    // Change two another filter list: End

    locationSearch(null);
  }

  void _addChosenMap({
    required Map<String, FilterItem> chosenMap,
    required Map<String, FilterItem> currentChosenMap,
    required Map<String, FilterItem> itemsMap,
  }) {
    if (chosenMap.isNotEmpty) {
      currentChosenMap.addAll(
        chosenMap,
      );
      for (final key in chosenMap.keys) {
        if (itemsMap.containsKey(key)) {
          itemsMap[key] = itemsMap[key]!.copyWith(isSelected: true);
        }
      }
    }
  }

  /// Helper to check if discount contain value from chosen list.
  /// discount field and chosen filter set use filterEnum
  bool _chosenListContainAnyValuesWithFilterEnum({
    required _FilterEnum filterEnum,
    required DiscountModel discount,
  }) {
    switch (filterEnum) {
      case _FilterEnum.category:
        return _chosenListContainAnyValues(
          values: discount.category,
          chosenFilter: activeCategoryMap,
        );
      case _FilterEnum.location:
        return _chosenListContainAnyValues(
          values: discount.subLocation == null
              ? discount.location
              : [
                  if (discount.location != null) ...discount.location!,
                  if (discount.subLocation != null) KAppText.sublocation,
                ],
          chosenFilter: activeLocationMap,
        );
      case _FilterEnum.eligibility:
        return _chosenListContainAnyValues(
          values: discount.eligibility?.getTranslateModels,
          chosenFilter: activeEligibilityMap,
        );
    }
  }

  /// Checks if chosen filter list contain translate model list.
  ///
  /// return true if chosen list empty
  ///
  /// return false if chosen list is not empty and translate model list is null
  ///
  /// return true/false if chosen list is not empty, translate model list is not null
  /// and if translate model list(uk value) contain every keys
  bool _chosenListContainAnyValues({
    required List<TranslateModel>? values,
    required Map<String, FilterItem> chosenFilter,
  }) {
    if (chosenFilter.isEmpty) {
      return true;
    } else if (values == null) {
      return false;
    } else {
      return values.any((value) => chosenFilter.containsKey(value.uk));
    }
  }

  /// Create Map<String, FilterItem> from List<TranslateModel>
  /// set is selected true for element where value.uk contain chosen map
  Map<String, FilterItem> _getFilterFromTranslateModel({
    required List<TranslateModel> list,
    required Map<String, FilterItem> chosenMap,
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
    // set is selected true if chosenMap contain value.uk/key
    for (final key in keysSorted) {
      filters.addAll({
        key: FilterItem(
          groupList[key]!.first,
          number: groupList[key]?.length ?? 1,
          isSelected: chosenMap.containsKey(key),
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
