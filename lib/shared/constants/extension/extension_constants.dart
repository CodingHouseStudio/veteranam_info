import 'dart:math';

import 'package:flutter/widgets.dart';
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

extension ItemLoadedExtensions on int {
  int getLoaded({required List<dynamic> list, int? loadItems}) => min(
        list.length,
        max(
          this,
          loadItems ?? KDimensions.loadItems,
        ),
      );
  bool checkLoadingPosible(List<dynamic> list) => this >= list.length;
}

extension LocalizedDateTime on DateTime {
  String toLocalDateString() {
    return toLocal().toString().split(' ')[0];
  }
}
