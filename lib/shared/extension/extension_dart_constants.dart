import 'dart:math' show max, min;
import 'dart:typed_data' show Uint8List;

import 'package:freezed_annotation/freezed_annotation.dart'
    show visibleForTesting;
import 'package:intl/intl.dart' show DateFormat;
import 'package:veteranam/shared/shared.dart';

extension ExtendedDateTime on DateTime {
  static DateTime? _customTime;
  static String? _id;

  static DateTime get current => _customTime ?? DateTime.now().toUtc();

  static String get id =>
      _id ?? DateTime.now().toLocal().microsecondsSinceEpoch.toString();

  @visibleForTesting
  static set current(DateTime? customTime) => _customTime = customTime;

  @visibleForTesting
  static set id(String? customId) => _id = customId;

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
  @visibleForTesting
  static String? ukDateString;
  @visibleForTesting
  static String? enDateString;

  String toLocalDateString({
    String? localeValue,
    bool showDay = false,
  }) {
    final locale = localeValue ?? Language.ukrain.value.languageCode;
    // initializeDateFormatting(locale);
    if (ukDateString != null && enDateString != null) {
      if (locale == Language.ukrain.value.languageCode) {
        return ukDateString!;
      }
      return enDateString!;
    }
    if (showDay) {
      return DateFormat.yMMMMd(locale).format(toLocal());
    } else {
      return DateFormat.yMMMM(locale).format(toLocal());
    }
  }
}

extension StringDartExtension on String {
  @visibleForTesting
  static DateTime? date;
  DateTime? getDateDiscountString(
    String locale,
  ) =>
      trim()
          .replaceAll('Up to ', '')
          .replaceAll('До ', '')
          .toLocaleDate(locale: locale, showDay: true);
  DateTime? toLocaleDate({
    required String locale,
    bool showDay = false,
  }) {
    if (date != null) {
      return date;
    }
    try {
      if (showDay) {
        return DateFormat.yMMMMd(locale).parse(this);
      } else {
        return DateFormat.yMMMM(locale).parse(this);
      }
    } catch (e) {
      // If DateFormat change format or our prevous discount had another format
      return null;
    }
  }

  // String customSubstring(int start, [int? end]) {
  //   return substring(start, end != null ? min(end, length) : null);
  // }

  String setStringLength(int maxLength) {
    if (length > maxLength) {
      return substring(0, maxLength);
    } else {
      return this;
    }
  }

  int compareUkrain(String b) {
    final minLength = length < b.length ? length : b.length;

    for (var i = 0; i < minLength; i++) {
      final aChar = this[i].toLowerCase();
      final bChar = b[i].toLowerCase();

      final aIndex = aChar._ukraineIndex;
      final bIndex = bChar._ukraineIndex;

      if (aIndex != bIndex) {
        return aIndex - bIndex;
      }
    }

    return length - b.length;
  }

  int get _ukraineIndex => KAppText.ukrainianAlphabet.indexOf(this);

  String? get getUserPlatform {
    final startIndex = indexOf('(');
    final endIndex = indexOf(')');

    if (startIndex == -1 || endIndex == -1 || startIndex > endIndex) {
      return null;
    }

    return substring(startIndex + 1, endIndex);
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

extension Uint8ListExtension on Uint8List {
  @visibleForTesting
  static FilePickerItem? imagePickerItem;
  FilePickerItem get parseToImagePickerItem =>
      imagePickerItem ??
      FilePickerItem(
        bytes: this,
        name: null,
        ref: null,
      );
}

// extension ReferenceExtension on Reference {
//   UploadTask putImage(Uint8List data, [SettableMetadata? metadata]) {
//     if (Config.isWeb) {
//       return putBlob(data, metadata);
//     } else {
//       return putData(data, metadata);
//     }
//   }
// }

extension CardEnumExtention on CardEnum {
  String get getValue {
    switch (this) {
      case CardEnum.funds:
        return 'funds';
      case CardEnum.discount:
        return 'discount';
      case CardEnum.information:
        return 'information';
      case CardEnum.story:
        return 'story';
    }
  }
}

extension DiscountStateExtention on DiscountState {
  String get enumString {
    switch (this) {
      case DiscountState.isNew:
        return 'isNew';
      case DiscountState.underReview:
        return 'underReview';
      // case DiscountState.overdue:
      //   return 'overdue';
      case DiscountState.rejected:
        return 'rejected';
      case DiscountState.published:
        return 'published';
      case DiscountState.deactivated:
        return 'deactivated';
    }
  }
}
