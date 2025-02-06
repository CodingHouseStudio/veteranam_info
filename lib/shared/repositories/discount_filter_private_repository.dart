part of 'discount_filter_repository.dart';

class _DiscountFilterRepository {
  _DiscountFilterRepository.init()
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
  const _DiscountFilterRepository.empty()
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

  static final UserRepository _userRepository = GetIt.I.get<UserRepository>();

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

  Either<SomeFailure, bool> _addRemoveFilterItem({
    required String valueUK,
    required Map<String, FilterItem> filter,
    required Map<String, FilterItem> activityFilter,
    required List<DiscountModel> unmodifiedDiscountModelItems,
    required _FilterEnum filterEnum,
    // required String callMethodName,
  }) {
    return eitherHelper(
      () {
        if (!filter.containsKey(valueUK) && !KTest.isTest) {
          return const Left(SomeFailure.filter);
        }
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
            // callMethodName: callMethodName,
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
              // callMethodName: callMethodName,
            )) {
              if (discount.eligibility.contains(EligibilityEnum.all)) {
                eligibilitiesList.addAll(
                  EligibilityEnum.valuesWithoutAll.getTranslateModels,
                );
              } else {
                eligibilitiesList
                    .addAll(discount.eligibility.getTranslateModels);
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
              // callMethodName: callMethodName,
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
              // callMethodName: callMethodName,
            )) {
              categoriesList.addAll(discount.category);
            }
          }
        }

        Left<SomeFailure, bool>? failure;

        // Romve prevoius value from filter Eligibilities and set new value
        if (filterEnum != _FilterEnum.eligibility) {
          failure = _getFilterFromTranslateModel(
            list: eligibilitiesList,
            activityMap: _activeEligibilityMap,
            // callMethodName: callMethodName,
          ).fold(
            Left.new,
            (r) {
              _eligibilityMap
                ..clear()
                ..addAll(
                  r,
                );
              return failure;
            },
          );
        }

        // Romve prevoius value from filter Location and set new value
        if (filterEnum != _FilterEnum.location) {
          failure = _getLocationFilterFromTranslateModel(
            list: locationList,
            activityMap: _activeLocationMap,
            // callMethodName: callMethodName,
          ).fold(
            Left.new,
            (r) {
              _locationMap
                ..clear()
                ..addAll(
                  r,
                );
              return failure;
            },
          );
        }

        // Romve prevoius value from filter Categories and set new value
        if (filterEnum != _FilterEnum.category) {
          failure = _getFilterFromTranslateModel(
            list: categoriesList,
            activityMap: _activeCategoryMap,
            // callMethodName: callMethodName,
          ).fold(
            Left.new,
            (r) {
              _categoryMap
                ..clear()
                ..addAll(
                  r,
                );
              return failure;
            },
          );
        }
        // Change two another filter list: End

        failure = _locationSearch(null).fold(
          Left.new,
          (r) => failure,
        );

        return failure ?? const Right(true);
      },
      user: _userRepository.currentUser,
      userSetting: _userRepository.currentUserSetting,
      data: 'valueUK: $valueUK | activityFilter: $activityFilter '
          '| filterEnum: $filterEnum',
      methodName: '_addFilterItem',
      className: 'Discount Filter ${ErrorText.repositoryKey}',
    );
  }

  Either<SomeFailure, bool> _addActivityMapToItemsMap({
    required Map<String, FilterItem> activityMap,
    required Map<String, FilterItem> itemsMap,
    // required String callMethodName,
  }) {
    return eitherHelper(
      () {
        if (activityMap.isNotEmpty) {
          for (final key in activityMap.keys) {
            if (itemsMap.containsKey(key)) {
              itemsMap[key] = itemsMap[key]!.copyWith(isSelected: true);
            }
          }
        }
        return const Right(true);
      },
      user: _userRepository.currentUser,
      userSetting: _userRepository.currentUserSetting,
      data: 'activityMap: $activityMap',
      methodName: '_addActivityMapToItemsMap',
      className: 'Discount Filter ${ErrorText.repositoryKey}',
    );
  }

  /// Helper to check if discount contain value from activity list.
  /// discount field and activity filter set use filterEnum
  bool _activityListContainAnyValuesWithFilterEnum({
    required _FilterEnum filterEnum,
    required DiscountModel discount,
    // required String callMethodName,
  }) {
    switch (filterEnum) {
      case _FilterEnum.category:
        return _activityListContainAnyValues(
          values: discount.category,
          activityFilter: _activeCategoryMap,
          // callMethodName: callMethodName,
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
          // callMethodName: callMethodName,
        );
      case _FilterEnum.eligibility:
        return _activityListContainAnyValues(
          values: discount.eligibility.getTranslateModels,
          activityFilter: _activeEligibilityMap,
          // callMethodName: callMethodName,
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
    // required String callMethodName,
  }) {
    return valueErrorHelper(
      () {
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
      },
      failureValue: false,
      methodName: 'Discount Filter ${ErrorText.repositoryKey}',
      className: '_activityListContainAnyValues',
      data: 'activityFilter: $activityFilter',
      user: _userRepository.currentUser,
      userSetting: _userRepository.currentUserSetting,
    );
  }

  /// Create Map<String, FilterItem> from List<TranslateModel>
  /// set is selected true for element where value.uk contain activity map
  Either<SomeFailure, Map<String, FilterItem>> _getFilterFromTranslateModel({
    required List<TranslateModel> list,
    required Map<String, FilterItem> activityMap,
    // required String callMethodName,
    List<String> Function(Map<String, List<TranslateModel>> list)?
        sortingMethod,
  }) {
    return eitherHelper(
      () {
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
      },
      user: _userRepository.currentUser,
      userSetting: _userRepository.currentUserSetting,
      data: 'activityMap: $activityMap',
      methodName: '_getFilterFromTranslateModel',
      className: 'Discount Filter ${ErrorText.repositoryKey}',
    );
  }

  /// Sorting location
  /// First five value sorting by number
  /// After first five value sorting by alphabet
  /// Language for alphabet sorting set use isEnglish
  Either<SomeFailure, Map<String, FilterItem>>
      _getLocationFilterFromTranslateModel({
    required List<TranslateModel> list,
    required Map<String, FilterItem> activityMap,
    // required String callMethodName,
  }) {
    return _getFilterFromTranslateModel(
      list: list,
      activityMap: activityMap,
      // callMethodName: callMethodName,
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
            .locationSorted(
              isEnglish: _userRepository.isEnglish,
              groupList: groupList,
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

  /// Serch location value in the location map.
  /// Search value in the uk and en values
  Either<SomeFailure, bool> _locationSearch(String? value) {
    return eitherHelper(
      () {
        if (value != null) {
          _DiscountFilterRepository._locationSearchValue = value.toLowerCase();
        }

        _locationSearchMap.clear();

        if (_DiscountFilterRepository._locationSearchValue.isEmpty) {
          _locationSearchMap.addAll(_locationMap);
        } else {
          final filterList = _locationMap.values.where(
            (element) =>
                element.value.uk.toLowerCase().startsWith(
                      _DiscountFilterRepository._locationSearchValue,
                    ) ||
                (element.value.en?.toLowerCase().startsWith(
                          _DiscountFilterRepository._locationSearchValue,
                        ) ??
                    false),
          );
          for (final value in filterList) {
            final key = value.value.uk;
            _locationSearchMap.addAll({key: _locationMap[key]!});
          }
        }
        return const Right(true);
      },
      user: _userRepository.currentUser,
      userSetting: _userRepository.currentUserSetting,
      data: value,
      methodName: 'locationSearch',
      className: 'Discount Filter ${ErrorText.repositoryKey}',
    );
  }
}

enum _FilterEnum {
  category,
  eligibility,
  location,
}
