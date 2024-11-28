part of 'discount_watcher_bloc.dart';

extension DiscountFailureExtension on SomeFailure {
  DiscountFailure _toDiscount() {
    return DiscountFailure.error;
  }
}

@freezed
class DiscountWatcherState with _$DiscountWatcherState {
  const factory DiscountWatcherState({
    required List<DiscountModel> unmodifiedDiscountModelItems,
    // required List<dynamic> chooseFilterItems,
    required DiscountFilterItems discountFilterItems,
    required List<DiscountEnum> sorting,
    required LoadingStatus loadingStatus,
    required DiscountFailure? failure,
    required List<DiscountModel> filteredDiscountModelItems,
    // required List<ReportModel> reportItems,
  }) = _Initial;
}

class DiscountFilterItems {
  const DiscountFilterItems._({
    required this.filterCategories,
    required this.choosenCategoriesnList,
    required this.filterLocation,
    required this.choosenLocationList,
    required this.filterEligibilities,
    required this.choosenEligibilitiesList,
  });

  const DiscountFilterItems.empty({
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

  bool get hasChoosenItem =>
      choosenEligibilitiesList.isEmpty &&
      choosenCategoriesnList.isEmpty &&
      choosenLocationList.isEmpty;

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

  // ignore: prefer_constructors_over_static_methods
  static DiscountFilterItems init({
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
      return DiscountFilterItems._(
        filterCategories: _getFilterFromTranslateModel(categoriesList),
        choosenCategoriesnList: {},
        filterLocation: filterLocationList,
        choosenLocationList: {},
        filterEligibilities: _getFilterFromTranslateModel(eligibilitiesList),
        choosenEligibilitiesList: {},
      );
    } catch (e) {
      return const DiscountFilterItems.empty();
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

// extension LocationGetter on List<DiscountModel> {
//   List<FilterItem> _getLocationItems(
//     List<DiscountModel>? listForFilter,
//   ) =>
//       <FilterItem>[
//         FilterItem(''),
//         FilterItem(''),
//         FilterItem(SubLocation.allStoresOfChain),
//         FilterItem(SubLocation.online),
//         ...overallItems(
//           getENFilter: (item) => item.location ?? [],
//           context: null,
//           numberGetList: listForFilter,
//         ),
//       ];
// }

extension SubLocationString on SubLocation {
  String get _getList {
    return KAppText.sulocationUA;
    // switch (this) {
    //   case SubLocation.all:
    //     return [
    //       SubLocation.allStoresOfChain,
    //       SubLocation.online,
    //     ];
    //   case SubLocation.allStoresOfChain:
    //   case SubLocation.online:
    //     return [this];
    // }
  }
}
