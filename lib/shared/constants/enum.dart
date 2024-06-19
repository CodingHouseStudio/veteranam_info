import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

extension ExtendedDateTime on DateTime {
  static DateTime? _customTime;
  static String? _id;

  static DateTime get current => _customTime ?? DateTime.now().toUtc();

  static String get id =>
      _id ?? DateTime.now().toLocal().microsecondsSinceEpoch.toString();

  @visibleForTesting
  static set current(DateTime customTime) => _customTime = customTime;

  @visibleForTesting
  static set id(String customId) => _id = customId;

  String get localeTime => toLocal().toString().split(' ')[0];
}

extension ExtendedImage on List<ImageModel>? {
  String? get firstImage =>
      this?.isNotEmpty ?? false ? this!.first.downloadURL : null;
}

extension LocalizedDateTime on DateTime {
  String toLocalDateString() {
    return toLocal().toString().split(' ')[0];
  }
}

enum LoadingStatus { initial, loading, loaded, error }

enum EvaluationEnum { like, dislike, smile, none }

extension ItemLoadedExtensions on int {
  int getLoaded({required List<dynamic> list, int? loadItems}) => min(
        list.length,
        max(
          this,
          loadItems ?? KDimensions.loadItems,
        ),
      );
  bool checkLoadingPosible(List<dynamic> list) =>
      this + KDimensions.loadItems > list.length;
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

    if (filtersIndex == null || filtersIndex.isEmpty) {
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

  List<String> overallItems({
    required List<String> Function(T) getFilter,
    required BuildContext context,
    List<String> Function(T)? getUAFilter,
  }) {
    final allFilters = <String>[];
    for (final item in this) {
      allFilters.addAll(
        context.read<AuthenticationBloc>().state.userSetting.locale ==
                    Language.english ||
                getUAFilter == null
            ? getFilter(item)
            : getUAFilter(item),
      );
    }
    return allFilters.toSet().toList();
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
      selectedFilters.add(eventFilterIndex);
    }

    return selectedFilters;
  }
}
