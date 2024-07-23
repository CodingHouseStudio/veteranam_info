import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:veteranam/shared/shared.dart';

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

// Extension for handling item loading logic on int
extension ItemLoadedExtensions on int {
  // Get the number of loaded items
  int getLoaded({required List<dynamic> list, int? loadItems}) =>
      min(list.length, max(this, loadItems ?? KDimensions.loadItems));

  // Check if loading more items is possible
  bool checkLoadingPosible(List<dynamic> list) => this > list.length;
}

extension LocalizedDateTime on DateTime {
  String toLocalDateString(BuildContext context) {
    final locale = context
        .read<AuthenticationBloc>()
        .state
        .userSetting
        .locale
        .value
        .languageCode;
    initializeDateFormatting(locale);
    return DateFormat.yMMMM(locale).format(toLocal());
  }
}

extension DiscountModelLocation on DiscountModel {
  List<String> fullLocationList(BuildContext context) => [
        if (location != null) ...location!,
        if (subLocation != null) ...subLocation!.getList(context),
      ];
}

extension StringExtension on String {
  bool get isUrlValid {
    const urlPattern = r'(https?://[^\s]+)';
    final regex = RegExp(
      urlPattern,
      caseSensitive: false,
    );
    return regex.hasMatch(this);
  }
}
