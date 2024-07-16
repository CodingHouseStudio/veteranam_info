import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

extension FilterItems on List<FilterItem> {
  List<FilterItem> get getToSet {
    return fold<List<FilterItem>>([], (acc, item) {
      final existingIndex =
          acc.indexWhere((element) => element.value == item.value);
      if (existingIndex >= 0) {
        acc.elementAt(existingIndex).number++;
      } else {
        acc.add(item);
      }
      return acc;
    });
  }
}

extension ListExtensions<T> on List<T> {
  List<T> loading({required int itemsLoaded, int? loadItems}) {
    if (isEmpty) return [];
    late int loadNumber;
    if (loadItems != null) {
      loadNumber = itemsLoaded + loadItems;
    } else {
      loadNumber = itemsLoaded;
    }
    final loadedItemsCount =
        loadNumber.getLoaded(list: this, loadItems: loadItems).clamp(0, length);

    return take(loadedItemsCount).toList();
  }

  List<T> removeReportItems({
    required List<ReportModel> reportItems,
    required String Function(T item) checkFunction,
  }) =>
      where(
        (item) => reportItems.every(
          (report) => report.cardId != checkFunction(item),
        ),
      ).toList();

  List<T> loadingFilter({
    required List<int>? filtersIndex,
    required int? itemsLoaded,
    required List<dynamic> Function(T item) getFilter,
    int? loadItems,
    List<dynamic>? overallFilter,
    List<T>? fullList,
    bool containAnyItems = true,
  }) {
    if (isEmpty) return [];

    final loadedItemsCount =
        (itemsLoaded?.getLoaded(list: this, loadItems: loadItems) ?? length) +
            (loadItems ?? 0);

    if (filtersIndex == null ||
        filtersIndex.isEmpty ||
        filtersIndex.contains(-1)) {
      return take(loadedItemsCount).toList();
    }
    final overallFilterValue = overallFilter ??
        overallItemBloc(getFilter: getFilter, fullList: fullList);

    final filtersText = filtersIndex
        .map(
          overallFilterValue.elementAt,
        )
        .toList();

    return where(
      (item) => containAnyItems
          ? filtersText.any(getFilter(item).contains)
          : filtersText.every(getFilter(item).contains),
    ).take(loadedItemsCount).toList();
  }

  List<dynamic> overallItemBloc({
    required List<dynamic> Function(T) getFilter,
    List<T>? fullList,
  }) {
    final allTags = <dynamic>[];
    for (final item in fullList ?? this) {
      allTags.addAll(
        getFilter(item),
      );
    }
    return allTags.toSet().toList();
  }

  List<int> updateFilterList({
    required List<dynamic> Function(T) getFilter,
    required List<T> previousList,
    required List<int> previousFilter,
    List<T>? fullList,
  }) {
    // Get overall items grouped by category and location
    final filter = overallItemBloc(getFilter: getFilter);

    // Find the difference in indices between category lists
    final differentCategoryIndices = previousList
        .overallItemBloc(getFilter: getFilter)
        .findDifferencesIndex(newList: filter);

    // Adjust filtersCategoriesIndex based on differences
    return previousFilter.adjustIndices(differentCategoryIndices);
  }

  List<int> findDifferencesIndex({required List<T> newList}) {
    final differentIndices = <int>[];
    var add = 0;
    for (var i = 0; i < length; i++) {
      if ((i < newList.length && newList[i] != elementAt(i)) ||
          (i >= newList.length && add <= 0)) {
        differentIndices.add(i);
        add++;
      } else if (i >= newList.length && add > 0) {
        add--;
      }
    }
    return differentIndices;
  }

  List<FilterItem> overallItems({
    required List<String> Function(T) getFilter,
    required BuildContext context,
    List<String> Function(T)? getUAFilter,
  }) {
    final allFilters = <FilterItem>[];
    for (final item in this) {
      allFilters.addAll(
        (context.read<AuthenticationBloc>().state.userSetting.locale ==
                        Language.english ||
                    getUAFilter == null
                ? getFilter(item)
                : getUAFilter(item))
            .map(
          FilterItem.new,
        ),
      );
    }
    return allFilters.getToSet;
  }

  LoadingStatus isLoading(List<T> previousList) {
    return length > previousList.length && length % KDimensions.loadItems == 0
        ? LoadingStatus.loaded
        : LoadingStatus.listLoadedFull;
  }

  LoadingStatus isLoadingFilter(
    List<T> previousList,
  ) {
    return length >= previousList.length && length % KDimensions.loadItems == 0
        ? LoadingStatus.loaded
        : LoadingStatus.listLoadedFull;
  }

  // List<T> filterIndex(T eventFilterIndex) {
  //   final selectedFilters = List<T>.from(this);

  //   if (selectedFilters.contains(eventFilterIndex)) {
  //     selectedFilters.remove(eventFilterIndex);
  //   } else {
  //     selectedFilters.add(eventFilterIndex);
  //   }

  //   return selectedFilters;
  // }

  List<T> filterIndexs(List<int> listIndex) {
    // Create a new list to store filtered items
    final filteredList = <T>[];

    // Iterate through each item in the original list
    for (final item in this) {
      // Check if the item's index is NOT in the list of indices to remove
      if (!listIndex.contains(indexOf(item))) {
        // If not, add the item to the new list
        filteredList.add(item);
      }
    }

    // Return the new filtered list
    return filteredList;
  }
}

extension ListExtensionsNull<T> on List<T>? {
  List<T> changeListValue(T eventFilterIndex) {
    final selectedFilters = List<T>.from(this ?? []);

    if (selectedFilters.contains(eventFilterIndex)) {
      selectedFilters.remove(eventFilterIndex);
    } else {
      if (eventFilterIndex == -1) {
        return [eventFilterIndex];
      }
      selectedFilters.add(eventFilterIndex);
      if (selectedFilters.contains(-1)) {
        selectedFilters.remove(-1);
      }
    }

    return selectedFilters;
  }
}

extension ExtendedImage on List<ImageModel>? {
  String? get firstImage =>
      this?.isNotEmpty ?? false ? this!.first.downloadURL : null;
}

extension ListIntExtension on List<int> {
  String getDiscountString(BuildContext context) {
    if (isEmpty) {
      return '';
    }
    if (length == 1) {
      if (first == 100) {
        return context.l10n.free;
      }
      return '${context.l10n.discount} $first%';
    }

    var highestItem = elementAt(0);
    for (var i = 1; i < length; i++) {
      if (elementAt(i) > highestItem) {
        highestItem = elementAt(i);
      }
    }
    return '${context.l10n.discounts} ${context.l10n.ofUpTo} $highestItem%';
  }

  List<int> adjustIndices(List<int> differences) {
    final adjustedIndices = <int>[];
    for (var element in this) {
      if (differences.any((index) => index == element)) {
        continue;
      }
      var numSmallerDifferences = 0;
      for (final index in differences) {
        if (index < element) {
          numSmallerDifferences--;
        }
      }
      element += numSmallerDifferences;

      adjustedIndices.add(element);
    }
    return adjustedIndices;
  }

  List<int> checkValue({
    required int filterIndex,
    required int equalNumber,
    required int largerNumber,
  }) {
    final newList = changeListValue(filterIndex);

    if (filterIndex == equalNumber) {
      newList.removeWhere((element) => element > largerNumber);
    } else if (filterIndex > largerNumber) {
      newList.removeWhere((element) => element == equalNumber);
    }

    return newList;
  }
}

extension DiscountModelExtensions on List<DiscountModel> {
  List<FilterItem> getLocationFilter(BuildContext context) {
    final list = context.read<DiscountWatcherBloc>().state.discountModelItems;
    return [
      FilterItem(context.l10n.fromLargestToSmallest),
      FilterItem(context.l10n.free),
      ...list.overallItems(
        getFilter: (item) => item.subLocation.getList(context),
        context: context,
      ),
      ...list.overallItems(
        getFilter: (item) => item.location ?? [],
        context: context,
      ),
    ];
  }
  // List<String> overallCategory(BuildContext context) {
  //   final allTags = <String>[];
  //   for (final item in this) {
  //     allTags.addAll(
  //       context.read<AuthenticationBloc>().state.userSetting.locale ==
  //               Language.english
  //           ? item.category
  //           : item.categoryUA,
  //     );
  //   }
  //   return allTags.toSet().toList();
  // }
}
