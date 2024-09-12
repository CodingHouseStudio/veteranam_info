import 'dart:async';
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:feedback/feedback.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb, kReleaseMode;
import 'package:flutter/widgets.dart';
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
  // List<String> fullLocationList(BuildContext context) => [
  //       if (location != null) ...location!,
  //       if (subLocation != null) ...subLocation!.getList(context),
  //     ];
  String getDescription(BuildContext context) =>
      '${context.isEnglish ? descriptionEN : description}\n'
      '\n***${context.l10n.toGetItYouNeed}***\n'
      '\n- ${context.isEnglish ? requirementsEN : requirements}\n'
      '\n${context.isEnglish ? exclusionsEN : exclusions}'
      '${additionalDetails != null ? _getMarkdownAdditionalDetails : ''}'
      '${phoneNumber != null ? _getMarkdownPhoneNumber(context) : ''}';

  String _getMarkdownAdditionalDetails(BuildContext context) => '\n\n'
      '${context.isEnglish ? additionalDetailsEN : additionalDetails ?? ''}';

  String _getMarkdownPhoneNumber(BuildContext context) =>
      '\n\n***${context.l10n.callForDetails}:***'
      ' ${KPlatformConstants.isWebDesktop ? '***' : '['}'
      '$phoneNumber'
      '${KPlatformConstants.isWebDesktop ? '***' : '](tel:'
          // ignore: lines_longer_than_80_chars
          '${phoneNumber!.replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '')})'}';

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
    // late String value;
    // if (fullText) {
    //   value = this;
    // } else {
    final lengthValue = isDesk
        ? KDimensions.descriptionDeskHideLength
        : KDimensions.descriptionMobHideLength;
    final end = length > lengthValue ? lengthValue : length;
    return '${markdownSubstring(end)}...';
    // }
    // return value;
    // .replaceAllMapped(RegExp(r'(https?://[^\s]+)'), (match) {
    //   final url = match.group(0);

    //   final hasEllipsis = match.end > value.length - 3;
    //   return url != null
    //       ? hasEllipsis
    //           ? url
    //           : '[$url]($url)'
    //       : '';
    // }).substring(
    //   0,
    // );
  }

  String markdownSubstring(int end) {
    final match = RegExp(r'([^\s]*https?://[^\s]+)').allMatches(this).where(
          (element) => element.start < end && element.end > end,
        );
    late var substringValue =
        substring(0, match.isEmpty ? end : match.first.start).trim();
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

  double getTextLength({
    required double? width,
    required TextStyle textStyle,
    double? additional,
  }) {
    if (width != null) return width;
    final textLength =
        length * (textStyle.fontSize! + textStyle.letterSpacing!) +
            (additional ?? 0);
    return textLength / KSize.kPixel2;
  }

  String? get getUserPlatform {
    final startIndex = indexOf('(');
    final endIndex = indexOf(')');

    if (startIndex == -1 || endIndex == -1 || startIndex > endIndex) {
      return null;
    }

    return substring(startIndex + 1, endIndex);
  }

  String get getImageUrl //({bool? highQuality})
  {
    if ((Config.isProduction && kReleaseMode) || !kIsWeb) {
      final url = kIsWeb ? Uri.base.origin : 'https://veteranam.info';
      return '$url$_urlPrefix$this';
    } else {
      return this;
    }
  }

  String get _urlPrefix //({bool? highQuality})
  {
    // widget.size == null
    // ?
    const quality = '85'; // highQuality ?? false ? '100' : '85';
    const format = 'auto'; // KPlatformConstants.isWebSaffari ? 'jpeg' : 'auto';
    return '/cdn-cgi/image/quality=$quality,format=$format/';
  }
  // : '/cdn-cgi/image/${kIsWeb ? 'quality=100' : 'quality=85'}'
  //     ',width=${widget.size! * 10},${widget.size! * 10}/';
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

  Future<void> onMobFeedback(UserFeedback feedback) async =>
      read<MobFeedbackBloc>().add(MobFeedbackEvent.send(feedback.screenshot));

  // void copyText(String text, String? href, String? title) =>
  //     read<UrlCubit>().copy(text);

  // void launchUrl(String? url) => read<UrlCubit>().launchUrl(url: url);
  // ignore: avoid_positional_boolean_parameters
  void emailDialogCloseEvent(bool? value) {
    if (!mounted) return;
    if (!(value ?? false)) {
      read<DiscountUserEmailFormBloc>().add(
        const DiscountUserEmailFormEvent.sendEmailAfterClose(),
      );
    }
  }
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

extension UrlEnumExtension on UrlEnum {
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
      case UrlEnum.copyEmailSucceed:
        return context.l10n.copyEmail;
      case UrlEnum.copyLinkSucceed:
        return context.l10n.copyLink;
    }
  }
}

extension FilterItemExtension on FilterItem {
  int alphabeteCompare({
    required FilterItem b,
    required BuildContext? context,
    required bool addEnglish,
  }) {
    if ((context?.isEnglish ?? false) && addEnglish) {
      return valueEN
          .toString()
          .toLowerCase()
          .compareTo(b.valueEN.toString().toLowerCase());
    } else {
      return value.toString().compareUkrain(b.value.toString());
    }
  }
}

extension UserRoleExtensions on UserRole {
  String value(BuildContext context) {
    switch (this) {
      case UserRole.businessmen:
        return context.l10n.iAmBusinessOwnerRepresentative;
      case UserRole.civilian:
        return context.l10n.iAmCivilian;
      case UserRole.relativeOfVeteran:
        return context.l10n.iAmRelativeOfVeteran;
      case UserRole.veteran:
        return context.l10n.iAmVeteran;
    }
  }
}

extension ImageNullableExtensions on ImageModel? {
  Widget? getImage({
    required Widget Function(Widget child) parent,
    Key? key,
    double? size,
    BoxFit? fit,
  }) {
    if (this == null) return null;
    return parent(
      NetworkImageWidget(
        key: key,
        imageUrl: this!.downloadURL,
        fit: fit,
        size: size,
        imageName: this!.name,
      ),
    );
  }
}

extension FundExtensions on FundModel {
  Widget get getImage {
    return image.getImage(
          parent: (child) => Expanded(child: child),
          key: KWidgetkeys.widget.donateCard.image,
        ) ??
        const Spacer();
  }
}

extension StoryExtensions on StoryModel {
  Widget get getImage =>
      userPhoto.getImage(
        parent: (child) => ClipRRect(
          borderRadius: BorderRadius.circular(KSize.kUserPhoto),
          child: child,
        ),
        fit: BoxFit.contain,
        size: KSize.kUserPhoto,
      ) ??
      IconWidget(
        key: KWidgetkeys.widget.storyCard.userIcon,
        icon: KIcon.person,
        background: AppColors.materialThemeKeyColorsNeutralVariant,
      );
}

// extension FirebaseAnalyticsExtensions on FirebaseAnalytics {
//   void releaseLogEvent({
//     required String name,
//     Map<String, Object>? parameters,
//     AnalyticsCallOptions? callOptions,
//   }) {
//     if (kReleaseMode && Config.isProduction) {
//       unawaited(
//         logEvent(
//           name: name,
//           callOptions: callOptions,
//           parameters: parameters,
//         ),
//       );
//     }
//   }
// }
