import 'dart:math' show max, min;

import 'package:collection/collection.dart' show IterableExtension;
import 'package:feedback/feedback.dart' show UserFeedback;
import 'package:firebase_storage/firebase_storage.dart'
    show Reference, SettableMetadata, UploadTask;
import 'package:flutter/foundation.dart'
    show Key, Uint8List, kIsWeb, kReleaseMode, visibleForTesting;
import 'package:flutter/material.dart'
    show
        BorderRadius,
        BoxFit,
        BuildContext,
        ClipRRect,
        Color,
        EdgeInsets,
        EdgeInsetsGeometry,
        Expanded,
        Spacer,
        TextDirection,
        TextPainter,
        TextSpan,
        TextStyle,
        Widget,
        showDatePicker;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:veteranam/components/components.dart'
    show
        DiscountEnum,
        DiscountUserEmailFormBloc,
        DiscountUserEmailFormEvent,
        ProfileEnum;
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
  String toLocalDateString({
    required BuildContext? context,
    String? localeValue,
    bool showDay = false,
  }) {
    final locale = context
            ?.read<AuthenticationBloc>()
            .state
            .userSetting
            .locale
            .value
            .languageCode ??
        localeValue ??
        Language.ukrain;
    // initializeDateFormatting(locale);
    if (showDay) {
      return DateFormat.yMMMMd(locale).format(toLocal());
    } else {
      return DateFormat.yMMMM(locale).format(toLocal());
    }
  }
}

extension DiscountModelLocation on DiscountModel {
  // List<String> fullLocationList(BuildContext context) => [
  //       if (location != null) ...location!,
  //       if (subLocation != null) ...subLocation!.getList(context),
  //     ];
  String getDescription(BuildContext context) =>
      '${description.getTrnslation(en: descriptionEN, context: context)}'
      '${requirements != null ? _getMarkdownToGetIfYouNeed(context) : ''}'
      '${requirements != null ? _getMarkdownRequirements(context) : ''}'
      '${exclusions != null ? _getMarkdownExclusions(context) : ''}\n'
      '${additionalDetails != null ? _getMarkdownAdditionalDetails(
          context,
        ) : ''}'
      '${phoneNumber != null ? _getMarkdownPhoneNumber(context) : ''}';

  String _getMarkdownAdditionalDetails(BuildContext context) =>
      '\n\n${additionalDetails.getTrnslation(
            en: additionalDetailsEN,
            context: context,
          ) ?? ''}';

  String _getMarkdownPhoneNumber(BuildContext context) =>
      '\n\n***${context.l10n.callForDetails}:***'
      ' ${PlatformEnum.isWebDesktop ? '***' : '['}'
      '$phoneNumber'
      '${PlatformEnum.isWebDesktop ? '***' : '](tel:'
          '${phoneNumber!.replaceAll('(', '').replaceAll(
                ')',
                '',
              ).replaceAll(' ', '')})'}';
  String _getMarkdownExclusions(BuildContext context) => '\n\n'
      '${exclusions.getTrnslation(
            en: exclusionsEN,
            context: context,
          ) ?? ''}';
  String _getMarkdownRequirements(BuildContext context) => '\n\n- '
      '${requirements.getTrnslation(
            en: requirementsEN,
            context: context,
          ) ?? ''}';
  String _getMarkdownToGetIfYouNeed(BuildContext context) =>
      '\n\n***${context.l10n.toGetItYouNeed}***';

  List<String> getCityList(BuildContext context) => [
        if (context.isEnglish)
          if (locationEN != null) ...locationEN!,
        if (!context.isEnglish)
          if (location != null) ...location!,
        if (subLocation != null) ...subLocation!.getCardList(context),
      ];

  String? get getLink => PlatformEnum.getPlatform.isIOS
      ? category.contains('Медицина')
          ? null
          : directLink ?? link
      : directLink ?? link;
}

extension StringExtension on String {
  DateTime toLocaleDate({
    required String locale,
    bool showDay = false,
  }) {
    // initializeDateFormatting(locale);
    if (showDay) {
      return DateFormat.yMMMMd(locale).parse(this);
    } else {
      return DateFormat.yMMMM(locale).parse(this);
    }
  }

  String customSubstring(int start, [int? end]) {
    return substring(start, end != null ? min(end, length) : null);
  }

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

  double getTextWidth({
    required TextStyle textStyle,
  }) {
    return TextPainter.computeWidth(
      text: TextSpan(text: this, style: textStyle),
      textDirection: TextDirection.ltr,
    );
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
    const quality = '100'; // highQuality ?? false ? '100' : '85';
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
    required T? en,
    required BuildContext context,
  }) =>
      context.isEnglish ? en ?? this : this;
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

  @visibleForTesting
  static DateTime? textPieckerData;

  Future<DateTime?> get getDate async =>
      textPieckerData ??
      showDatePicker(
        context: this,
        initialDate: ExtendedDateTime.current,
        firstDate: ExtendedDateTime.current,
        lastDate: DateTime(2026),
      );
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
    if (Config.isWeb) {
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

extension DoubleExtensions on double {
  EdgeInsetsGeometry screenPadding({
    required double precent,
    double? verticalPadding,
    double? horizontalPadding,
    bool notUseHorizontal = true,
  }) {
    const threshold = KPlatformConstants.maxWidthThresholdTablet;
    final horizontalPaddingValue = this <= threshold
        ? this * precent
        : threshold * precent + ((this - threshold) / 2);

    return EdgeInsets.symmetric(
      horizontal: notUseHorizontal
          ? horizontalPaddingValue
          : horizontalPadding ?? KPadding.kPaddingSize16,
      vertical: verticalPadding ?? 0,
    );
  }
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

  String text(BuildContext context) {
    switch (this) {
      case DiscountState.isNew:
      case DiscountState.underReview:
        return context.l10n.underReview;
      // case DiscountState.overdue:
      //   return context.l10n.overdue;
      case DiscountState.rejected:
        return context.l10n.rejected;
      case DiscountState.published:
        return context.l10n.published;
      case DiscountState.deactivated:
        return context.l10n.deactivated;
    }
  }

  Color get color {
    switch (this) {
      case DiscountState.isNew:
      case DiscountState.underReview:
        return AppColors.materialThemeRefNeutralNeutral99;
      // case DiscountState.overdue:
      //   return AppColors.materialThemeRefTertiaryTertiary98;
      case DiscountState.rejected:
        return AppColors.materialThemeRefErrorError98;
      case DiscountState.published:
        return AppColors.materialThemeRefSecondarySecondary99;
      case DiscountState.deactivated:
        return AppColors.materialThemeRefTertiaryTertiary90;
    }
  }

  Color get pointColor {
    switch (this) {
      case DiscountState.isNew:
      case DiscountState.underReview:
        return AppColors.materialThemeSysLightTertiary;
      // case DiscountState.overdue:
      //   return AppColors.materialThemeRefTertiaryTertiary60;
      case DiscountState.rejected:
        return AppColors.materialThemeRefErrorError40;
      case DiscountState.published:
        return AppColors.materialThemeRefPrimaryPrimary80;
      case DiscountState.deactivated:
        return AppColors.materialThemeRefTertiaryTertiary70;
    }
  }
}

extension UserExtensions on User? {
  String? get firstName => this?.name?.split(' ').first;

  String? get lastName => this?.name?.split(' ').last;
}
