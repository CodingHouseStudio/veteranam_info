import 'package:collection/collection.dart' show groupBy;
import 'package:flutter/material.dart' show BuildContext;
//TODO: remove it
import 'package:veteranam/shared/extension/extension_dart.dart';
import 'package:veteranam/shared/shared_flutter.dart';

/// Extension for filtering FilterItem list items.
extension FilterItems on List<FilterItem> {
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
  // String getCityList({
  //   required bool showFullText,
  //   required BuildContext context,
  // }) {
  //   if (showFullText) {
  //     return '$first [${context.l10n.moreCities(
  //       length - 1,
  //     )}]()';
  //   } else {
  //     return '${map(
  //       (e) => '$e | ',
  //     ).join()}[${context.l10n.hideExpansion}]()';
  //   }
  // }
  String getCityString({
    required bool showFullText,
    // required BuildContext context,
  }) {
    if (showFullText) {
      return first;
    } else {
      return toString();
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

extension ListBoolExtension on List<bool> {
  bool fundsCardChangeSize(int index) {
    if (indexOf(true) < length - 1) {
      return indexOf(true) + 1 == index;
    } else {
      return indexOf(true) - 1 == index;
    }
  }
}
