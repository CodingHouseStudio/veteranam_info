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
  // Private constructor for initializing the object with specific filter data.
  const FilterItemsModel._({
    required this.filterCategories,
    required this.chosenCategoriesList,
    required this.filterLocation,
    required this.chosenLocationList,
    required this.filterEligibilities,
    required this.chosenEligibilitiesList,
  });

  /// Constructor to initialize an empty maps.
  const FilterItemsModel.empty({
    this.filterCategories = const {},
    this.chosenCategoriesList = const {},
    this.filterLocation = const {},
    this.chosenLocationList = const {},
    this.filterEligibilities = const {},
    this.chosenEligibilitiesList = const {},
  });

  // Maps to store current available filters
  final Map<String, FilterItem> filterEligibilities;
  final Map<String, FilterItem> filterCategories;
  final Map<String, FilterItem> filterLocation;

  // Maps to store current selected user filters
  final Map<String, FilterItem> chosenEligibilitiesList;
  final Map<String, FilterItem> chosenCategoriesList;
  final Map<String, FilterItem> chosenLocationList;

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
      filter: filterCategories,
      chosenFilter: chosenCategoriesList,
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
      filter: filterLocation,
      chosenFilter: chosenLocationList,
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
      filter: filterEligibilities,
      chosenFilter: chosenEligibilitiesList,
      unmodifiedDiscountModelItems: unmodifiedDiscountModelItems,
      filterEnum: _FilterEnum.eligibility,
    );
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
      chosenEligibilitiesList.isNotEmpty ||
      chosenCategoriesList.isNotEmpty | chosenLocationList.isNotEmpty;

  /// Combines all chosen filters into a single map.
  Map<String, FilterItem> get getchosenList => {
        ...chosenEligibilitiesList,
        ...chosenCategoriesList,
        ...chosenLocationList,
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
    filter[valueUK] = filterItem;
    final chooseValue = chosenFilter[valueUK];
    if (chooseValue == null) {
      chosenFilter[valueUK] = filterItem;
    } else {
      chosenFilter.remove(valueUK);
    }
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
            eligibilitiesList.addAll(discount.eligibility!);
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
      filterEligibilities
        ..clear()
        ..addAll(
          _getFilterFromTranslateModel(
            list: eligibilitiesList,
            chosenMap: chosenEligibilitiesList,
          ),
        );
    }

    // Romve prevoius value from filter Location and set new value
    if (filterEnum != _FilterEnum.location) {
      filterLocation
        ..clear()
        ..addAll(
          _getFilterFromTranslateModel(
            list: locationList,
            chosenMap: chosenLocationList,
          ),
        );
    }

    // Romve prevoius value from filter Categories and set new value
    if (filterEnum != _FilterEnum.category) {
      filterCategories
        ..clear()
        ..addAll(
          _getFilterFromTranslateModel(
            list: categoriesList,
            chosenMap: chosenCategoriesList,
          ),
        );
    }
    // Change two another filter list: End
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
          chosenFilter: chosenCategoriesList,
        );
      case _FilterEnum.location:
        return _chosenListContainAnyValues(
          values: discount.location,
          chosenFilter: chosenLocationList,
        );
      case _FilterEnum.eligibility:
        return _chosenListContainAnyValues(
          values: discount.eligibility,
          chosenFilter: chosenEligibilitiesList,
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
      return chosenFilter.keys.every(
        (key) => values.any((element) => element.uk == key),
      );
      // return values.any((value) => chosenFilter.containsKey(value.uk));
    }
  }

  // ignore: prefer_constructors_over_static_methods
  static FilterItemsModel init({
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
    required Map<String, FilterItem> chosenCategories,
    required Map<String, FilterItem> chosenLocation,
    required Map<String, FilterItem> chosenEligibilities,
  }) {
    try {
      final categoriesList = <TranslateModel>[];
      final locationList = <TranslateModel>[];
      final eligibilitiesList = <TranslateModel>[];

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

      return FilterItemsModel._(
        filterCategories: _getFilterFromTranslateModel(
          list: categoriesList,
          chosenMap: chosenCategories,
        ),
        chosenCategoriesList: chosenCategories.isEmpty ? {} : chosenCategories,
        filterLocation: _sortingLocation(
          locationMap: _getFilterFromTranslateModel(
            list: locationList,
            chosenMap: chosenLocation,
          ),
          isEnglish: isEnglish,
        ),
        chosenLocationList: chosenLocation.isEmpty ? {} : chosenLocation,
        filterEligibilities: _getFilterFromTranslateModel(
          list: eligibilitiesList,
          chosenMap: chosenEligibilities,
        ),
        chosenEligibilitiesList:
            chosenEligibilities.isEmpty ? {} : chosenEligibilities,
      );
    } catch (e) {
      return const FilterItemsModel.empty();
    }
  }

  /// Create Map<String, FilterItem> from List<TranslateModel>
  /// set is selected true for element where value.uk contain chosen map
  static Map<String, FilterItem> _getFilterFromTranslateModel({
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
  static Map<String, FilterItem> _sortingLocation({
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
