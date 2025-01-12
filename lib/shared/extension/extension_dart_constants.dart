import 'dart:math' show max, min;
import 'dart:typed_data' show Uint8List;

import 'package:freezed_annotation/freezed_annotation.dart'
    show visibleForTesting;
import 'package:intl/intl.dart' show DateFormat;
import 'package:veteranam/shared/shared_dart.dart';

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

  String? get getUserPlatform {
    final startIndex = indexOf('(');
    final endIndex = indexOf(')');

    if (startIndex == -1 || endIndex == -1 || startIndex > endIndex) {
      return null;
    }

    return substring(startIndex + 1, endIndex);
  }

  EligibilityEnum get toEligibility {
    switch (toLowerCase()) {
      case 'ветерани':
        return EligibilityEnum.veterans;
      case 'військовослужбовці':
        return EligibilityEnum.militaryPersonnel;
      case 'учасники бойових дій':
        return EligibilityEnum.combatants;
      case 'особи з інвалідністю внаслідок війни':
        return EligibilityEnum.personsWithDisabilitiesDueToWar;
      case 'поліція':
        return EligibilityEnum.policeOfficers;
      case 'співробітники дснс':
        return EligibilityEnum.emergencyServiceEmployees;
      case 'члени сімей загиблих':
        return EligibilityEnum.familyMembersOfTheDeceased;
      // case 'внутрішньо переміщені особи':
      //   return EligibilityEnum.internallyDisplacedPersons;
      case 'всі перелічені':
        return EligibilityEnum.all;
    }
    return EligibilityEnum.all;
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

extension FilterItemExtension on FilterItem {
  int alphabeteCompare({
    required FilterItem b,
    required bool? isEnglish,
    required bool addEnglish,
  }) {
    if ((isEnglish ?? false) && addEnglish) {
      return value.en?.compareTo(b.value.en.toString().toLowerCase()) ?? -1;
    } else {
      return value.uk.compareUkrain(b.value.uk);
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

  String get getErrorData => 'Image Length - $length';
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

extension DateFieldModelDart on DateFieldModel {
  TranslateModel get getString => TranslateModel(
        uk: 'До ${value?.toLocalDateString(
          localeValue: Language.ukrain.value.languageCode,
          showDay: true,
        )}',
        en: 'Up to ${value?.toLocalDateString(
          localeValue: Language.english.value.languageCode,
          showDay: true,
        )}',
      );
}

// extension UrlFailureExtension on SomeFailure {
//   UrlEnum toUrl() {
//     switch (this) {
//       case SomeFailure.share:
//         return UrlEnum.shareError;
//       case SomeFailure.link:
//         return UrlEnum.linkError;
//       case SomeFailure.copy:
//         return UrlEnum.copyError;
//       // ignore: no_default_cases
//       default:
//         return UrlEnum.error;
//     }
//   }
// }

extension ErrorLevelEnumExtension on ErrorLevelEnum? {
  String get getString {
    switch (this) {
      case ErrorLevelEnum.error:
        return 'ERROR';
      case ErrorLevelEnum.fatal:
        return 'FATAL ERROR';
      case ErrorLevelEnum.info:
        return 'info';
      case ErrorLevelEnum.warning:
        return 'Warning';
      case null:
        return '';
    }
  }

  int get getLevel {
    switch (this) {
      case ErrorLevelEnum.error:
        return KDimensions.logLevelError;
      case ErrorLevelEnum.fatal:
        return KDimensions.logLevelCriticalError;
      case ErrorLevelEnum.info:
        return KDimensions.logLevelInfo;
      case ErrorLevelEnum.warning:
        return KDimensions.logLevelWarning;
      case null:
        return KDimensions.logLevelWarning;
    }
  }

  int get getSequenceNumber {
    switch (this) {
      case ErrorLevelEnum.error:
        return KDimensions.sequenceNumberError;
      case ErrorLevelEnum.fatal:
        return KDimensions.sequenceNumberCriticalError;
      case ErrorLevelEnum.info:
        return KDimensions.sequenceNumber;
      case ErrorLevelEnum.warning:
        return KDimensions.sequenceNumberWarning;
      case null:
        return KDimensions.sequenceNumber;
    }
  }
}

extension FilePickerItemExtension on FilePickerItem? {
  String? get getErrorData => this == null
      ? null
      : 'Image/File: name - ${this!.name}, extension - ${this!.extension},'
          ' path - ${this!.ref}, ${this!.bytes.getErrorData}';
}

extension TranslateModelExtension on TranslateModel {
  String getTrsnslation({
    required bool isEnglish,
  }) =>
      isEnglish ? en ?? uk : uk;
}

extension EligiblityEnumExtension on EligibilityEnum {
  TranslateModel get getTranslateModel {
    switch (this) {
      case EligibilityEnum.veterans:
        return const TranslateModel(
          uk: 'Ветерани',
          en: 'Veterans',
        );
      case EligibilityEnum.combatants:
        return const TranslateModel(
          uk: 'Учасники бойових дій',
          en: 'Combatants',
        );
      case EligibilityEnum.militaryPersonnel:
        return const TranslateModel(
          uk: 'Військовослужбовці',
          en: 'Military personnel',
        );
      case EligibilityEnum.familyMembersOfTheDeceased:
        return const TranslateModel(
          uk: 'Члени сімей загиблих',
          en: 'Fallen family members',
        );
      case EligibilityEnum.personsWithDisabilitiesDueToWar:
        return const TranslateModel(
          uk: 'Особи з інвалідністю внаслідок війни',
          en: 'Disabled war veterans',
        );
      case EligibilityEnum.emergencyServiceEmployees:
        return const TranslateModel(
          uk: 'Співробітники ДСНС',
          en: 'State Emergency Service employees',
        );
      case EligibilityEnum.policeOfficers:
        return const TranslateModel(
          uk: 'Поліція',
          en: 'Police officers',
        );
      // case EligibilityEnum.internallyDisplacedPersons:
      //   return const TranslateModel(
      //     uk: 'Внутрішньо переміщені особи',
      //     en: 'Internally displaced persons',
      //   );
      case EligibilityEnum.all:
        return KAppText.eligibilityAll;
    }
  }
}

extension CompanyModelExtension on CompanyModel {
  bool get isAdmin => id == KAppText.adminCompanyID;
}

extension UriExtension on Uri {
  static String get baseUrl =>
      Config.isWeb && !KTest.isTest ? Uri.base.origin : KAppText.site;
}
