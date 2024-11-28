import 'package:collection/collection.dart';
import 'package:veteranam/shared/shared_dart.dart';

class FilterItemsModel {
  const FilterItemsModel._({
    required this.filterCategories,
    required this.choosenCategoriesnList,
    required this.filterLocation,
    required this.choosenLocationList,
    required this.filterEligibilities,
    required this.choosenEligibilitiesList,
  });

  const FilterItemsModel.empty({
    this.filterCategories = const {},
    this.choosenCategoriesnList = const {},
    this.filterLocation = const {},
    this.choosenLocationList = const {},
    this.filterEligibilities = const {},
    this.choosenEligibilitiesList = const {},
  });

  final Map<String, FilterItem> filterCategories;
  final Map<String, FilterItem> choosenCategoriesnList;
  final Map<String, FilterItem> filterLocation;
  final Map<String, FilterItem> choosenLocationList;
  final Map<String, FilterItem> filterEligibilities;
  final Map<String, FilterItem> choosenEligibilitiesList;

  void addCategory(String valueUK) {
    _addFilterItem(
      valueUK: valueUK,
      filter: filterCategories,
      choosenFilter: choosenCategoriesnList,
    );
  }

  void addLocation(String valueUK) {
    _addFilterItem(
      valueUK: valueUK,
      filter: filterLocation,
      choosenFilter: choosenLocationList,
    );
  }

  void addEligibility(String valueUK) {
    _addFilterItem(
      valueUK: valueUK,
      filter: filterEligibilities,
      choosenFilter: choosenEligibilitiesList,
    );
  }

  void clearChooseItems() {
    _clearIsSelecter(
      filter: filterCategories,
      choosenFilter: choosenCategoriesnList,
    );
    _clearIsSelecter(
      filter: filterEligibilities,
      choosenFilter: choosenEligibilitiesList,
    );
    _clearIsSelecter(
      filter: filterLocation,
      choosenFilter: choosenLocationList,
    );
    choosenCategoriesnList.clear();
    choosenEligibilitiesList.clear();
    choosenLocationList.clear();
  }

  bool get hasChoosenItem =>
      choosenEligibilitiesList.isNotEmpty ||
      choosenCategoriesnList.isNotEmpty | choosenLocationList.isNotEmpty;

  Map<String, FilterItem> get getChoosenList => {
        ...choosenEligibilitiesList,
        ...choosenCategoriesnList,
        ...choosenLocationList,
      };

  void _addFilterItem({
    required String valueUK,
    required Map<String, FilterItem> filter,
    required Map<String, FilterItem> choosenFilter,
  }) {
    final value = filter[valueUK];
    final filterItem = value?.copyWith(isSelected: !value.isSelected) ??
        FilterItem(
          TranslateModel(uk: valueUK),
        );
    filter[valueUK] = filterItem;
    final chooseValue = choosenFilter[valueUK];
    if (chooseValue == null) {
      choosenFilter[valueUK] = filterItem;
    } else {
      choosenFilter.remove(valueUK);
    }
  }

  void _clearIsSelecter({
    required Map<String, FilterItem> filter,
    required Map<String, FilterItem> choosenFilter,
  }) {
    for (final key in choosenFilter.keys) {
      final value = filter[key];
      if (value != null) filter[key] = value.copyWith(isSelected: false);
    }
  }

  // ignore: prefer_constructors_over_static_methods
  static FilterItemsModel init({
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required bool isEnglish,
  }) {
    try {
      final categoriesList = <TranslateModel>[];
      final locationList = <TranslateModel>[];
      final eligibilitiesList = <TranslateModel>[];

      for (final discount in unmodifiedDiscountModelItems) {
        categoriesList.addAll(discount.category);
        if (discount.location != null) {
          locationList.addAll(discount.location!);
        }
        if (discount.subLocation != null) {
          locationList.add(KAppText.sublocation);
        }
        if (discount.eligibility != null) {
          eligibilitiesList.addAll(discount.eligibility!);
        }
      }
      final locationEntries =
          _getFilterFromTranslateModel(locationList).entries;
      final filterLocationList = Map.fromEntries(
        [
          ...locationEntries
              .take(KDimensions.discountLocationNumberSortedItems),
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
      return FilterItemsModel._(
        filterCategories: _getFilterFromTranslateModel(categoriesList),
        choosenCategoriesnList: {},
        filterLocation: filterLocationList,
        choosenLocationList: {},
        filterEligibilities: _getFilterFromTranslateModel(eligibilitiesList),
        choosenEligibilitiesList: {},
      );
    } catch (e) {
      return const FilterItemsModel.empty();
    }
  }

  static Map<String, FilterItem> _getFilterFromTranslateModel(
    List<TranslateModel> list,
  ) {
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
        ),
      });
    }
    return filters;
  }
}
