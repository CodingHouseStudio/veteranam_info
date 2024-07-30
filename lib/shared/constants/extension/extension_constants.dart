import 'dart:math';
import 'package:collection/collection.dart';
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
  String getDescription(BuildContext context) => '$description\n'
      '\n***${context.l10n.toGetItYouNeed}***\n'
      '\n$requirements\n'
      '\n$exclusions\n'
      // ignore: lines_longer_than_80_chars
      '${additionalDetails != null ? '\n${additionalDetails ?? ''}\n' : ''}'
      '\n***${context.l10n.callForDetails}:***'
      ' ${KPlatformConstants.isWebDesktop ? '***' : '['}'
      '$phoneNumber'
      '${KPlatformConstants.isWebDesktop ? '***' : '](tel:'
          // ignore: lines_longer_than_80_chars
          '${phoneNumber.replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '')})'}';
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

  String markdownCard({required bool isDesk, required bool fullText}) {
    if (fullText) {
      return this;
    }
    late String value;
    if (fullText) {
      value = this;
    } else {
      final lengthValue = isDesk
          ? KDimensions.descriptionDeskHideLength
          : KDimensions.descriptionMobHideLength;
      final end = length > lengthValue ? lengthValue : length;
      value = '${markdownSubstring(end)}...';
    }
    return value.replaceAllMapped(RegExp(r'(https?://[^\s]+)'), (match) {
      final url = match.group(0);

      final hasEllipsis = match.end > value.length - 3;
      return url != null
          ? hasEllipsis
              ? url
              : '[$url]($url)'
          : '';
    }).substring(
      0,
    );
  }

  String markdownSubstring(int end) {
    late var substringValue = substring(0, end).trim();
    while (substringValue.endsWith('*')) {
      substringValue = substringValue.substring(0, substringValue.length - 1);
    }
    final markdownSymbols = ['***', '**', '*'];

    for (final markdownSymbol in markdownSymbols) {
      final indexes = <int>[];
      substringValue.split('').forEachIndexed((index, character) {
        if (substringValue.substring(index).startsWith(markdownSymbol)) {
          indexes.add(index);
        }
      });

      if (!indexes.length.isEven) {
        return '$substringValue$markdownSymbol';
      }
    }

    return substringValue.endsWith('- ')
        ? substringValue.substring(0, substringValue.length - 2)
        : substringValue.endsWith('-')
            ? substringValue.substring(0, substringValue.length - 1)
            : substringValue;
  }
}
