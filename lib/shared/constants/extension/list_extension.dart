import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

/// Extension for filtering FilterItem list items.
extension FilterItems on List<FilterItem> {
  /// Get a list of FilterItem with summarized values.
  List<FilterItem> getToSet(List<FilterItem>? numberGetList) {
    final grouped = groupBy(this, (FilterItem item) => item.value);

    return grouped.entries.map((entry) {
      final item = FilterItem(
        entry.key,
        valueEN: entry.value.first.valueEN,
        number:
            numberGetList?.where((item) => item.value == entry.key).length ??
                entry.value.length,
      );

      return item;
    }).toList();
  }

  /// Method to find indices where differences occur between this list and a new
  ///  list.
  ///
  /// Parameters:
  /// - newList: New list to compare with.
  ///
  /// Returns:
  /// A list of indices where differences were found.
  // List<int> findDifferencesIndex({required List<FilterItem> newList}) {
  //   if (length == newList.length) {
  //     return [];
  //   }
  //   final differentIndices =
  //       <int>[]; // Initialize an empty list for storing different indices.
  //   var add = 0; // Variable to track how many indices need to be added to
  //   // differentIndices.

  //   // Iterate through indices of the current list.
  //   for (var i = 0; i < length; i++) {
  //     // Check if the index i is within bounds of newList and if elements at i
  //     // differ.
  //     if ((i < newList.length &&
  //             newList.elementAt(i).value != elementAt(i).value) ||
  //         (i >= newList.length && add <= i)) {
  //       differentIndices
  //           .add(i); // Add index i to differentIndices if there's a difference.
  //       add--; // Increment add to indicate that an index was added.
  //     } else if (i >= newList.length && add > 0) {
  //       add++; // Decrement add if index i is beyond newList's length and was
  //       // previously added.
  //     }
  //   }

  //   return differentIndices; // Return the list of indices where differences
  //   // were found.
  // }
}

extension ListReportModelExtensions on List<ReportModel> {
  List<String> get getIdCard => map(
        (e) => e.cardId,
      ).toList();
}

extension ListStringExtensions on List<String> {
  String getCityList({
    required bool showFullText,
    required BuildContext context,
  }) {
    if (showFullText) {
      return '$first [${context.l10n.moreCities(
        length - 1,
      )}]()';
    } else {
      return '${map(
        (e) => '$e | ',
      ).join()}[${context.l10n.hideExpansion}]()';
    }
  }
}

/// Extension providing utility methods for List<T>.
extension ListExtensions<T> on List<T> {
  /// Method to get the list of loaded items.
  ///
  /// Parameters:
  /// - itemsLoaded: Number of items already loaded.
  /// - loadItems: Number of additional items to load.
  ///
  /// Returns:
  /// A list containing the loaded items.
  List<T> loading({required int itemsLoaded, int? loadItems}) {
    if (isEmpty) return []; // Return empty list if original list is empty

    // Calculate the total number of items to load
    final loadNumber = (itemsLoaded + (loadItems ?? 0)).getLoaded(list: this);

    // Return the first `loadedItemsCount` items of the list
    return take(loadNumber).toList();
  }

  /// Method to remove items based on report items.
  ///
  /// Parameters:
  /// - reportItems: List of report items.
  /// - checkFunction: Function to retrieve a unique identifier from each item.
  ///
  /// Returns:
  /// A list with items not matching any report card ID.
  List<T> removeReportItems({
    required List<ReportModel> reportItems,
    required String Function(T item) checkFunction,
  }) {
    // Create a set of report card IDs for efficient lookup
    final reportCardIds = reportItems.map((report) => report.cardId).toSet();

    // Filter items that do not have a matching report card ID
    return where((item) => !reportCardIds.contains(checkFunction(item)))
        .toList();
  }

  /// Method to check and modify list based on specific filter conditions.
  ///
  /// Parameters:
  /// - filterIndex: Index to compare with list elements.
  /// - equalNumber: Number for equality comparison.
  /// - largerNumber: Number for comparison with larger values.
  ///
  /// Returns:
  /// Modified list based on the provided filter conditions.
  List<T> checkValue({
    required T filterValue,
    required T? equalValue,
    // required int largerNumber,
  }) {
    final newList = changeListValue(
      eventFilter: filterValue,
      removeValue: equalValue,
    );

    // Conditionally remove elements from 'newList' based on filter conditions
    // if (filterValue == equalValue) {
    //   newList.removeWhere((element) => element > largerNumber);
    // } else if (contains(element)) {
    //   newList.removeWhere((element) => element == equalNumber);
    // }

    return newList;
  }

  /// Method to filter and load items based on multiple filters.
  ///
  /// Parameters:
  /// - filtersIndex: Indexes of filters to apply.
  /// - itemsLoaded: Number of items already loaded.
  /// - getFilter: Function to retrieve filter values from an item.
  /// - loadItems: Number of items to load.
  /// - overallFilter: Pre-calculated overall filter values.
  /// - fullList: Full list of items to filter.
  /// - containAnyItems: Flag indicating whether to match any filter or all
  /// filters.
  ///
  /// Returns:
  /// A filtered and loaded list of items.
  List<T> loadingFilter({
    required List<dynamic>? filtersValue,
    required int? itemsLoaded,
    required List<dynamic> Function(T item) getENFilter,
    int? loadItems,
    // List<FilterItem>? overallFilter,
    // List<T>? fullList,
    // List<T>? listForFilter,
    // bool containAnyItems = true,
  }) {
    // Calculate the total number of items to load
    final loadedItemsCount =
        (itemsLoaded?.getLoaded(list: this, loadItems: loadItems) ?? length) +
            (loadItems ?? 0);

    // Apply filters to the list and return up to 'loadedItemsCount' items
    return _filter(
      filtersValue: filtersValue,
      getFilter: getENFilter,
      // overallFilter: overallFilter,
      // fullList: fullList,
      // containAnyItems: containAnyItems,
      // listForFilter: listForFilter,
    ).take(loadedItemsCount).toList();
  }

  ({List<T> list, LoadingStatus loadingStatus}) combiningFilteredLists({
    required List<T> secondList,
    required int itemsLoaded,
    // List<T> Function(List<T> list)? sorting,
    int? loadItems,
  }) {
    // Calculate the total number of items to load
    final loadedItemsCount =
        itemsLoaded.getLoaded(list: this, loadItems: loadItems) +
            (loadItems ?? 0);
    final list = toSet().intersection(secondList.toSet()).toList();
    // late var sortingList = list;
    // if (sorting != null) {
    //   sortingList = sorting(sortingList);
    // }
    return (
      list: list.take(loadedItemsCount).toList(),
      loadingStatus: list.getLoadingStatus(loadedItemsCount)
    );
  }

  /// Method to filter items based on multiple filters.
  ///
  /// Parameters:
  /// - filtersIndex: Indexes of filters to apply.
  /// - getFilter: Function to retrieve filter values from an item.
  /// - overallFilter: Pre-calculated overall filter values.
  /// - fullList: Full list of items to filter.
  /// - containAnyItems: Flag indicating whether to match any filter or all
  /// filters.
  ///
  /// Returns:
  /// A filtered list of items.
  List<T> _filter({
    required List<dynamic>? filtersValue,
    required List<dynamic> Function(T item) getFilter,
    // required List<FilterItem>? overallFilter,
    // required List<T>? fullList,
    // required bool containAnyItems,
    // List<T>? listForFilter,
  }) {
    if (isEmpty) return []; // Return empty list if the input list is empty

    // Return the full list if no specific filters are applied
    if (filtersValue == null ||
        filtersValue.isEmpty ||
        filtersValue.contains(CategoryEnum.all)) {
      return this;
    }

    // Calculate overall filter values if not provided
    // final overallFilterValue = overallFilter ??
    //     overallItems(
    //       getENFilter: getFilter,
    //       fullList: fullList,
    //       context: null,
    //       numberGetList: listForFilter,
    //     );

    // Retrieve filter texts based on filter indexes
    // final filtersText =
    //     filtersIndex.map((e) => overallFilterValue.elementAt(e).value).
    // toList();

    // Apply filters to the list
    return where(
      (item) =>
          //  containAnyItems
          //     ?
          filtersValue.any(
        getFilter(item).contains,
      ), // Match any filter if 'containAnyItems' is true
      // : filtersValue.every(
      //     getFilter(item).contains,
      //   ), // Match all filters if 'containAnyItems' is false
    ).toList();
  }

  /// Method to filter items, load a specific number of items, and return the
  /// loading status.
  ///
  /// Parameters:
  /// - filtersIndex: Indexes of filters to apply.
  /// - itemsLoaded: Number of items already loaded.
  /// - getFilter: Function to retrieve filter values from an item.
  /// - loadItems: Number of items to load.
  /// - overallFilter: Pre-calculated overall filter values.
  /// - fullList: Full list of items to filter.
  /// - containAnyItems: Flag indicating whether to match any filter or all
  /// filters.
  ///
  /// Returns:
  /// A tuple containing a filtered and loaded list of items and the loading
  /// status.
  ({List<T> list, LoadingStatus loadingStatus}) loadingFilterAndStatus({
    required List<dynamic>? filtersValue,
    required int? itemsLoaded,
    required List<dynamic> Function(T item) getFilter,
    int? loadItems,
    // List<FilterItem>? overallFilter,
    // List<T>? fullList,
    // bool containAnyItems = true,
    // List<T>? listForFilter,
  }) {
    // Apply filters to the list
    final list = _filter(
      filtersValue: filtersValue,
      getFilter: getFilter,
      // overallFilter: overallFilter,
      // fullList: fullList,
      // containAnyItems: containAnyItems,
      // listForFilter: listForFilter,
    );

    // Calculate the total number of items to load
    final loadedItemsCount =
        (itemsLoaded?.getLoaded(list: this, loadItems: loadItems) ?? length) +
            (loadItems ?? 0);

    // Determine the loading status based on the number of loaded items
    final loadingStatus = list.getLoadingStatus(loadedItemsCount);

    // Return the filtered and loaded list along with the loading status
    return (
      list: list.take(loadedItemsCount).toList(),
      loadingStatus: loadingStatus
    );
  }

  LoadingStatus getLoadingStatus(int loadedItemsCount) =>
      length <= loadedItemsCount && isNotEmpty
          ? LoadingStatus.listLoadedFull
          : LoadingStatus.loaded;

  /// Method to calculate overall filter values.
  ///
  /// Parameters:
  /// - getFilter: Function to retrieve filter values from an item.
  /// - fullList: Full list of items to calculate overall filters from.
  ///
  /// Returns:
  /// A list of unique filter values from all items.
  // List<dynamic> overallItemBloc({
  //   required List<dynamic> Function(T) getFilter,
  //   List<T>? fullList,
  // }) {
  //   // Initialize an empty list to hold all tags.
  //   final allTags = <dynamic>[];

  //   // Iterate through each item in the fullList or this (if fullList is null).
  //   for (final item in fullList ?? this) {
  //     // Add all tags retrieved from the current item using getFilter to
  //     // allTags.
  //     allTags.addAll(getFilter(item));
  //   }

  //   // Convert the list to a set to remove duplicates, then convert back to a
  //   // list.
  //   return allTags.toSet().toList();
  // }

  /// Method to update filter indices based on changes in a list.
  ///
  /// Parameters:
  /// - getFilter: Function to retrieve filter values from an item.
  /// - previousList: Previous list of items.
  /// - previousFilter: Previous filter indices.
  /// - fullList: Full list of items to calculate overall filters from.
  ///
  /// Returns:
  /// Updated filter indices adjusted based on changes in filter values.
  // List<int> updateFilterList({
  //   required List<dynamic> Function(T) getFilter,
  //   required List<T> previousList,
  //   required List<int> previousFilter,
  //   List<T>? fullList,
  // }) {
  //   if (previousList.isEmpty ||
  //       (previousList.length == 1 && previousList.first == -1)) {
  //     return previousFilter;
  //   }
  //   // Get overall items grouped by category and location
  //   final filter = overallItems(getFilter: getFilter, context: null);

  //   // Find the difference in indices between category lists
  //   final differentCategoryIndices = previousList
  //       .overallItems(getFilter: getFilter, context: null)
  //       .findDifferencesIndex(newList: filter);

  //   // Adjust filtersCategoriesIndex based on differences
  //   return previousFilter.adjustIndices(differentCategoryIndices);
  // }

  /// Method to calculate overall items and return them as FilterItem instances.
  ///
  /// Parameters:
  /// - getFilter: Function to retrieve filter values from an item.
  /// - context: BuildContext for accessing necessary resources.
  /// - getUAFilter: Optional function to retrieve Ukrainian filter values.
  ///
  /// Returns:
  /// A list of FilterItem instances with summarized filter values.
  List<FilterItem> overallItems({
    required BuildContext? context,
    required List<dynamic> Function(T) getUAFilter,
    List<dynamic> Function(T)? getENFilter,
    List<T>? fullList,
    List<T>? numberGetList,
  }) {
    final allFilters = <FilterItem>[];
    for (final item in fullList ?? this) {
      for (var i = 0; i < (getUAFilter(item).length); i++) {
        allFilters.add(
          FilterItem(
            getUAFilter(item).elementAt(i),
            valueEN:
                getENFilter == null ? null : getENFilter(item).elementAt(i),
          ),
        );
      }
    }
    final allNumberFilters = numberGetList == null ? null : <FilterItem>[];
    if (numberGetList != null) {
      for (final item in numberGetList) {
        allNumberFilters!.addAll(
          getUAFilter(item).map(
            FilterItem.new,
          ),
        );
      }
    }
    final allFiltersList = allFilters.getToSet(allNumberFilters).toList()
      ..sort((a, b) {
        final numberSort = b.number.compareTo(a.number);
        if (numberSort == 0) {
          return a.alphabeteCompare(
            b: b,
            context: context,
            addEnglish: getENFilter != null,
          );
        }
        return numberSort;
      });

    final firstFive = allFiltersList.take(5).toList();
    final remaining = allFiltersList.skip(5).toList()
      ..sort(
        (a, b) => a.alphabeteCompare(
          b: b,
          context: context,
          addEnglish: getENFilter != null,
        ),
      );

    final sortedList = [...firstFive, ...remaining];

    return sortedList;
  }

  /// Method to determine loading status based on previous list length.
  ///
  /// Parameters:
  /// - previousList: Previous list of items.
  /// - isFilter: Flag indicating whether the list is a filter.
  ///
  /// Returns:
  /// LoadingStatus based on the comparison of current and previous list
  ///  lengths.
  // LoadingStatus isLoading(List<T> previousList, {bool isFilter = false}) {
  //   // Determine if loading status is based on filter or regular list length
  //   // comparison.
  //   return (isFilter
  //               ? length >= previousList.length
  //               : length > previousList.length) &&
  //           length % KDimensions.loadItems == 0
  //       ? LoadingStatus
  //           .loaded // Return loaded if conditions meet loading criteria.
  //       : LoadingStatus
  //           .listLoadedFull; // Return listLoadedFull if loading is complete.
  // }

  /// Method to filter items based on a list of indices.
  ///
  /// Parameters:
  /// - listIndex: List of indices to filter.
  ///
  /// Returns:
  /// A list containing items not indexed in 'listIndex'.
  // List<T> filterIndexs(List<int> listIndex) {
  //   // Create a new list to store filtered items
  //   final filteredList = <T>[];

  //   // Iterate through each item in the original list
  //   for (final item in this) {
  //     // Check if the item's index is NOT in the list of indices to remove
  //     if (!listIndex.contains(indexOf(item))) {
  //       // If not, add the item to the new list
  //       filteredList.add(item);
  //     }
  //   }

  //   // Return the new filtered list
  //   return filteredList;
  // }
}

/// Extension providing utility methods for handling nullable lists.
extension ListExtensionsNull<T> on List<T>? {
  /// Method to toggle an element's presence in the list.
  ///
  /// Parameters:
  /// - eventFilter: Element to toggle.
  ///
  /// Returns:
  /// A list with eventFilter added or removed based on its current
  ///  presence.
  List<T> changeListValue({required T eventFilter, T? removeValue}) {
    // Create a copy of the current list or an empty list if the original is
    // null.
    final selectedFilters = List<T>.from(this ?? []);

    // Toggle the presence of eventFilterIndex in selectedFilters.
    if (selectedFilters.contains(eventFilter)) {
      selectedFilters.remove(eventFilter); // Remove if already present.
    } else {
      if (eventFilter == removeValue || selectedFilters.contains(removeValue)) {
        return [
          eventFilter,
        ]; // Return a list with -1 if it's the special case.
      }
      selectedFilters.add(
        eventFilter,
      ); // Add eventFilterIndex if not already present.

      // Remove -1 if it exists to ensure it's not duplicated.
      // if (selectedFilters.contains(-1)) {
      //   selectedFilters.remove(-1);
      // }
    }

    return selectedFilters; // Return the modified list.
  }
}

/// Extension on List<ImageModel> providing utility methods for image handling.
// extension ExtendedImage on List<ImageModel>? {
//   /// Property to get the download URL of the first image in the list.
//   String? get firstImage =>
//       this?.isNotEmpty ?? false ? this!.first.downloadURL : null;
// }

/// Extension on List<int> providing utility methods for handling discount
///  values.
extension ListIntExtension on List<int> {
  /// Returns a formatted discount string based on the list elements.
  ///
  /// Parameters:
  /// - context: BuildContext for accessing localized resources.
  ///
  /// Returns:
  /// Formatted discount string representing discount values.
  String getDiscountString(BuildContext context) {
    if (isEmpty) {
      return ''; // Return empty string if list is empty.
    }
    if (length == 1) {
      if (this[0] == 100) {
        return context.l10n.free; // Return 'Free' if discount is 100%.
      }
      return '${context.l10n.discount} ${this[0]}%'; // Return formatted
      // discount percentage.
    }

    // Find the highest discount percentage in the list.
    final highestItem =
        reduce((value, element) => value > element ? value : element);

    return '${context.l10n.discounts} ${context.l10n.ofUpTo} $highestItem%';
    // Return formatted string with highest discount.
  }

  /// Method to adjust list indices based on differences with another list.
  ///
  /// Parameters:
  /// - differences: List of index differences.
  ///
  /// Returns:
  /// Adjusted list indices after accounting for differences.
  // List<int> adjustIndices(List<int> differences) {
  //   if (differences.isEmpty) {
  //     return this;
  //   }
  //   final adjustedIndices = <int>[];

  //   // Iterate through each element in the list
  //   for (var element in this) {
  //     // Skip elements that are in the 'differences' list
  //     if (differences.any((index) => index == element)) {
  //       continue;
  //     }

  //     var numSmallerDifferences = 0;
  //     for (final index in differences) {
  //       if (index < element) {
  //         numSmallerDifferences++;
  //       }
  //     }

  //     // Adjust 'element' based on the number of smaller differences found
  //     element += numSmallerDifferences;

  //     // Add adjusted 'element' to the result list
  //     adjustedIndices.add(element);
  //   }

  //   return adjustedIndices;
  // }
}

/// Extension on List<DiscountModel> providing utility methods for DiscountModel
/// operations.
extension DiscountModelExtensions on List<DiscountModel> {
  /// Method to retrieve location filters based on context.
  ///
  /// Parameters:
  /// - context: BuildContext for accessing necessary resources.
  ///
  /// Returns:
  /// A list of FilterItem instances representing location filters.
  List<FilterItem> getLocationFilter(BuildContext context) {
    // Return a list of FilterItem instances
    return [
      // Filter items for overall locations sorted from largest to smallest
      // FilterItem(context.l10n.fromLargestToSmallest),
      // Filter item for free items
      // FilterItem(context.l10n.free),
      // Additional filters based on sub-locations using overallItems method
      ...overallItems(
        getUAFilter: (item) => item.subLocation?.getList(context) ?? [],
        context: context,
        // numberGetList: context
        //     .read<DiscountWatcherBloc>()
        //     .state
        //     .categoryDiscountModelItems,
      ),
      // Additional filters based on primary locations using overallItems method
      ...overallItems(
        getENFilter: (item) => item.locationEN ?? [],
        getUAFilter: (item) => item.location ?? [],
        context: context,
        // numberGetList: context
        //     .read<DiscountWatcherBloc>()
        //     .state
        //     .categoryDiscountModelItems,
      ),
    ];
  }
}

extension ConnectivityExtension on List<ConnectivityResult> {
  bool get hasNetwork => any(
        (result) => ConnectivityResult.none != result,
      );
}
