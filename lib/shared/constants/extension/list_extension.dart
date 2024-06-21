import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

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
    final loadedItemsCount = itemsLoaded
        .getLoaded(list: this, loadItems: loadItems)
        .clamp(0, length);

    return take(loadedItemsCount).toList();
  }

  List<T> loadingFilter({
    required List<int>? filtersIndex,
    required int? itemsLoaded,
    required List<dynamic> Function(T item) getFilter,
    int? loadItems,
    List<T>? fullList,
    List<dynamic>? overallFilter,
  }) {
    if (isEmpty) return [];

    final loadedItemsCount =
        itemsLoaded?.getLoaded(list: this, loadItems: loadItems) ??
            (fullList ?? this).length;

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

    return where((item) => filtersText.every(getFilter(item).contains))
        .take(loadedItemsCount)
        .toList();
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

  List<T> filterIndex(T eventFilterIndex) {
    final selectedFilters = List<T>.from(this);

    if (selectedFilters.contains(eventFilterIndex)) {
      selectedFilters.remove(eventFilterIndex);
    } else {
      selectedFilters.add(eventFilterIndex);
    }

    return selectedFilters;
  }
}

extension ListExtensionsNull<T> on List<T>? {
  List<T> filterIndex(T eventFilterIndex) {
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
