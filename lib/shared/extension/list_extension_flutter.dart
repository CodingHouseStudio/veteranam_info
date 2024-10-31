import 'package:collection/collection.dart' show groupBy;
import 'package:flutter/material.dart' show BuildContext;
import 'package:veteranam/shared/shared_flutter.dart';

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
  List<FilterItem> overallItems({
    required BuildContext? context,
    required List<dynamic> Function(T) getUAFilter,
    List<dynamic>? Function(T)? getENFilter,
    List<T>? fullList,
    List<T>? numberGetList,
  }) {
    try {
      final allFilters = <FilterItem>[];
      for (final item in fullList ?? this) {
        for (var i = 0; i < (getUAFilter(item).length); i++) {
          allFilters.add(
            FilterItem(
              getUAFilter(item).elementAt(i),
              valueEN: getENFilter == null
                  ? null
                  : getENFilter(item)?.elementAtOrNull(i),
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
    } catch (e) {
      return [];
    }
  }
}

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

extension ListBoolExtension on List<bool> {
  bool fundsCardChangeSize(int index) {
    if (indexOf(true) < length - 1) {
      return indexOf(true) + 1 == index;
    } else {
      return indexOf(true) - 1 == index;
    }
  }
}
