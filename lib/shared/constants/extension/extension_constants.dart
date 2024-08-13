import 'dart:math';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart' show BuildContext, visibleForTesting;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:veteranam/components/components.dart';
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
  int getLoaded({required List<dynamic> list, int? loadItems}) => min(
        list.length,
        max(this, (loadItems == 0 ? null : loadItems) ?? KDimensions.loadItems),
      );

  // Check if loading more items is possible
  bool checkLoadingPosible(List<dynamic> list) => this >= list.length;
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
  String getDescription(BuildContext context) =>
      '${context.isEnglish ? descriptionEN : description}\n'
      '\n***${context.l10n.toGetItYouNeed}***\n'
      '\n- ${context.isEnglish ? requirementsEN : requirements}\n'
      '\n${context.isEnglish ? exclusionsEN : exclusions}\n'
      // ignore: lines_longer_than_80_chars
      '${additionalDetails != null ? '\n${context.isEnglish ? additionalDetailsEN : additionalDetails ?? ''}\n' : ''}'
      '\n***${context.l10n.callForDetails}:***'
      ' ${KPlatformConstants.isWebDesktop ? '***' : '['}'
      '$phoneNumber'
      '${KPlatformConstants.isWebDesktop ? '***' : '](tel:'
          // ignore: lines_longer_than_80_chars
          '${phoneNumber.replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '')})'}';

  List<String> getCityList(BuildContext context) => [
        if (context.isEnglish)
          if (locationEN != null) ...locationEN!,
        if (!context.isEnglish)
          if (location != null) ...location!,
        if (subLocation != null) ...subLocation!.getCardList(context),
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

  String setStringLength(int maxLength) {
    if (length > maxLength) {
      return substring(0, maxLength);
    } else {
      return this;
    }
  }

  SubLocation? getSublocation(BuildContext context) {
    if (this == SubLocation.all.getList(context).first) {
      return SubLocation.all;
    }
    // if (this == SubLocation.online.getList(context).first) {
    //   return SubLocation.online;
    // }
    return null;
  }
}

extension InformationModelExtension on InformationModel {
  int? getLike({required bool isLiked}) {
    if (isLiked) {
      return likes ?? 1;
    } else if (likes != null && likes! > 1) {
      return likes! - 1;
    } else {
      return null;
    }
  }
}

extension GenericsExtensions<T> on T {
  T getTrnslation({
    required T en,
    required BuildContext context,
  }) =>
      context.isEnglish ? en : this;
}

extension ContextExtensions on BuildContext {
  bool get isEnglish =>
      read<AuthenticationBloc>().state.userSetting.locale.isEnglish;
}

extension DiscountEnumExtensions on DiscountEnum {
  String getValue(BuildContext context) {
    switch (this) {
      case DiscountEnum.free:
        return context.l10n.free;
      case DiscountEnum.largestSmallest:
        return context.l10n.fromLargestToSmallest;
    }
  }
}

extension CategoryEnumExtensions on CategoryEnum {
  String getValue(BuildContext context) {
    switch (this) {
      case CategoryEnum.all:
        return context.l10n.all;
    }
  }
}

extension ReferenceExtension on Reference {
  UploadTask putImage(Uint8List data, [SettableMetadata? metadata]) {
    if (KTest.testIsWeb) {
      return putBlob(data, metadata);
    } else {
      return putData(data, metadata);
    }
  }
}

extension UrlEnumValue on UrlEnum {
  String value(BuildContext context) {
    switch (this) {
      case UrlEnum.error:
        return context.l10n.error;
      case UrlEnum.shareError:
        return context.l10n.shareFailure;
      case UrlEnum.linkError:
        return context.l10n.linkFailure;
      case UrlEnum.copyError:
        return context.l10n.copyFailure;
      case UrlEnum.copySucceed:
        return context.l10n.copyEmail;
    }
  }
}
