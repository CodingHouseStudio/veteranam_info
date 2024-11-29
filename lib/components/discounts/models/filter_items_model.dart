import 'package:collection/collection.dart';
import 'package:veteranam/shared/shared_dart.dart';

class FilterItemsModel {
  const FilterItemsModel._({
    required this.filterCategories,
    required this.chosenCategoriesList,
    required this.filterLocation,
    required this.chosenLocationList,
    required this.filterEligibilities,
    required this.chosenEligibilitiesList,
  });

  const FilterItemsModel.empty({
    this.filterCategories = const {},
    this.chosenCategoriesList = const {},
    this.filterLocation = const {},
    this.chosenLocationList = const {},
    this.filterEligibilities = const {},
    this.chosenEligibilitiesList = const {},
  });

  final Map<String, FilterItem> filterCategories;
  final Map<String, FilterItem> chosenCategoriesList;
  final Map<String, FilterItem> filterLocation;
  final Map<String, FilterItem> chosenLocationList;
  final Map<String, FilterItem> filterEligibilities;
  final Map<String, FilterItem> chosenEligibilitiesList;

  void addCategory({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  }) {
    _addFilterItem(
      valueUK: valueUK,
      filter: filterCategories,
      chosenFilter: chosenCategoriesList,
    );

    final eligibilitiesList = <TranslateModel>[];
    final locationList = <TranslateModel>[];

    for (final discount in unmodifiedDiscountModelItems) {
      if (chosenListContainAnyValues(
        values: discount.category,
        chosenFilter: chosenCategoriesList,
      )) {
        // Eligibility
        if (chosenListContainAnyValues(
          values: discount.location,
          chosenFilter: chosenLocationList,
        )) {
          if (discount.eligibility != null) {
            eligibilitiesList.addAll(discount.eligibility!);
          }
        }

        // Location
        if (chosenListContainAnyValues(
          values: discount.eligibility,
          chosenFilter: chosenEligibilitiesList,
        )) {
          if (discount.location != null) {
            locationList.addAll(discount.location!);
          }
          if (discount.subLocation != null) {
            locationList.add(KAppText.sublocation);
          }
        }
      }
    }

    filterEligibilities
      ..clear()
      ..addAll(
        _getFilterFromTranslateModel(
          list: eligibilitiesList,
          chosenMap: chosenEligibilitiesList,
        ),
      );

    filterLocation
      ..clear()
      ..addAll(
        _getFilterFromTranslateModel(
          list: locationList,
          chosenMap: chosenLocationList,
        ),
      );
  }

  void addLocation({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  }) {
    _addFilterItem(
      valueUK: valueUK,
      filter: filterLocation,
      chosenFilter: chosenLocationList,
    );

    final categoriesList = <TranslateModel>[];
    final eligibilityList = <TranslateModel>[];

    for (final discount in unmodifiedDiscountModelItems) {
      if (chosenListContainAnyValues(
        values: discount.location,
        chosenFilter: chosenLocationList,
      )) {
        // Category
        if (chosenListContainAnyValues(
          values: discount.eligibility,
          chosenFilter: chosenEligibilitiesList,
        )) {
          categoriesList.addAll(discount.category);
        }

        // Eligibility
        if (chosenListContainAnyValues(
          values: discount.category,
          chosenFilter: chosenCategoriesList,
        )) {
          if (discount.eligibility != null) {
            eligibilityList.addAll(discount.eligibility!);
          }
        }
      }
    }

    filterCategories
      ..clear()
      ..addAll(
        _getFilterFromTranslateModel(
          list: categoriesList,
          chosenMap: chosenEligibilitiesList,
        ),
      );

    filterEligibilities
      ..clear()
      ..addAll(
        _getFilterFromTranslateModel(
          list: eligibilityList,
          chosenMap: chosenEligibilitiesList,
        ),
      );
  }

  void addEligibility({
    required String valueUK,
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  }) {
    // Add Eligibility to lists: Start
    _addFilterItem(
      valueUK: valueUK,
      filter: filterEligibilities,
      chosenFilter: chosenEligibilitiesList,
    );
    // Add Eligibility to lists: End

    final categoriesList = <TranslateModel>[];
    final locationList = <TranslateModel>[];

    for (final discount in unmodifiedDiscountModelItems) {
      if (chosenListContainAnyValues(
        values: discount.eligibility,
        chosenFilter: chosenEligibilitiesList,
      )) {
        // Category
        if (chosenListContainAnyValues(
          values: discount.location,
          chosenFilter: chosenLocationList,
        )) {
          categoriesList.addAll(discount.category);
        }

        // Location
        if (chosenListContainAnyValues(
          values: discount.category,
          chosenFilter: chosenCategoriesList,
        )) {
          if (discount.location != null) {
            locationList.addAll(discount.location!);
          }
          if (discount.subLocation != null) {
            locationList.add(KAppText.sublocation);
          }
        }
      }
    }

    filterCategories
      ..clear()
      ..addAll(
        _getFilterFromTranslateModel(
          list: categoriesList,
          chosenMap: chosenCategoriesList,
        ),
      );

    filterLocation
      ..clear()
      ..addAll(
        _getFilterFromTranslateModel(
          list: locationList,
          chosenMap: chosenLocationList,
        ),
      );
  }

  List<DiscountModel> getFilterList(
    List<DiscountModel> unmodifiedDiscountModelItems,
  ) {
    final filterList = <DiscountModel>[];

    for (final discount in unmodifiedDiscountModelItems) {
      if (chosenListContainAnyValues(
            values: discount.category,
            chosenFilter: chosenCategoriesList,
          ) &&
          chosenListContainAnyValues(
            values: discount.location,
            chosenFilter: chosenLocationList,
          ) &&
          chosenListContainAnyValues(
            values: discount.eligibility,
            chosenFilter: chosenEligibilitiesList,
          )) {
        filterList.add(discount);
      }
    }

    return filterList;
  }

  bool get haschosenItem =>
      chosenEligibilitiesList.isNotEmpty ||
      chosenCategoriesList.isNotEmpty | chosenLocationList.isNotEmpty;

  Map<String, FilterItem> get getchosenList => {
        ...chosenEligibilitiesList,
        ...chosenCategoriesList,
        ...chosenLocationList,
      };

  void _addFilterItem({
    required String valueUK,
    required Map<String, FilterItem> filter,
    required Map<String, FilterItem> chosenFilter,
  }) {
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
  }

  bool chosenListContainAnyValues({
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

  static Map<String, FilterItem> _getFilterFromTranslateModel({
    required List<TranslateModel> list,
    required Map<String, FilterItem> chosenMap,
  }) {
    final groupList = groupBy(
      list,
      (value) => value.uk,
    );

    final filters = <String, FilterItem>{};
    final keysSorted = groupList.keys.sorted(
      (a, b) => groupList[b]!.length.compareTo(
            groupList[a]!.length,
          ),
    );
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

  static Map<String, FilterItem> _sortingLocation({
    required Map<String, FilterItem> locationMap,
    required bool isEnglish,
  }) {
    final locationEntries = locationMap.entries;
    return Map.fromEntries(
      [
        ...locationEntries.take(KDimensions.discountLocationNumberSortedItems),
        ...locationEntries
            .skip(KDimensions.discountLocationNumberSortedItems)
            .sorted(
          (a, b) {
            if (isEnglish && a.value.value.en != null) {
              return a.value.value.en!
                  .compareTo(b.value.value.en.toString().toLowerCase());
            } else {
              return a.value.value.uk.compareUkrain(b.value.value.uk);
            }
          },
        ),
      ],
    );
  }
}
