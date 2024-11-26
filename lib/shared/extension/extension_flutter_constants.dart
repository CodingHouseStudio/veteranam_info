import 'package:collection/collection.dart' show IterableExtension;
import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart' show Key, defaultTargetPlatform;
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
        MouseCursor,
        Spacer,
        SystemMouseCursors,
        TargetPlatform,
        TextDirection,
        TextPainter,
        TextSpan,
        TextStyle,
        Widget,
        WidgetState,
        WidgetStateProperty,
        showDatePicker,
        visibleForTesting;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:veteranam/shared/shared_flutter.dart';

extension LocalizedDateTime on DateTime {
  @visibleForTesting
  static String? ukDateString;
  @visibleForTesting
  static String? enDateString;

  String toLocalDateString({
    required BuildContext? context,
    bool showDay = false,
  }) {
    final locale = context?.read<LanguageCubit>().state.value.languageCode ??
        Language.ukrain.value.languageCode;
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

extension DiscountModelLocation on DiscountModel {
  // List<String> fullLocationList(BuildContext context) => [
  //       if (location != null) ...location!,
  //       if (subLocation != null) ...subLocation!.getList(context),
  //     ];
  String getDescription(BuildContext context) =>
      '${description.getTrsnslation(context)}'
      '${requirements != null ? _getMarkdownToGetIfYouNeed(context) : ''}'
      '${requirements != null ? _getMarkdownRequirements(context) : ''}'
      '${exclusions != null ? _getMarkdownExclusions(context) : ''}\n'
      '${additionalDetails != null ? _getMarkdownAdditionalDetails(
          context,
        ) : ''}'
      '${phoneNumber != null ? _getMarkdownPhoneNumber(context) : ''}';

  String _getMarkdownAdditionalDetails(BuildContext context) =>
      '\n\n${additionalDetails?.getTrsnslation(
            context,
          ) ?? ''}';

  String _getMarkdownPhoneNumber(BuildContext context) =>
      '\n\n***${context.l10n.callForDetails}:***'
      ' ${PlatformEnumFlutter.isWebDesktop ? '***' : '['}'
      '$phoneNumber'
      '${PlatformEnumFlutter.isWebDesktop ? '***' : '](tel:'
          '${phoneNumber!.replaceAll('(', '').replaceAll(
                ')',
                '',
              ).replaceAll(' ', '')})'}';
  String _getMarkdownExclusions(BuildContext context) => '\n\n'
      '${exclusions?.getTrsnslation(
            context,
          ) ?? ''}';
  String _getMarkdownRequirements(BuildContext context) => '\n\n- '
      '${requirements?.getTrsnslation(
            context,
          ) ?? ''}';
  String _getMarkdownToGetIfYouNeed(BuildContext context) =>
      '\n\n***${context.l10n.toGetItYouNeed}***';

  String? get getLink => PlatformEnum.getPlatform.isIOS
      ? category
              .where(
                (element) => element.uk.contains('Медицина'),
              )
              .isNotEmpty
          ? null
          : _getLink
      : _getLink;

  String? get _getLink =>
      directLink != null && directLink!.isUrlValid ? directLink : link;
}

extension StringFllutterExtension on String {
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

  // SubLocation? getSublocation(BuildContext context) {
  //   if (this == SubLocation.all.getList(context).first) {
  //     return SubLocation.all;
  //   }
  //   // if (this == SubLocation.online.getList(context).first) {
  //   //   return SubLocation.online;
  //   // }
  //   return null;
  // }

  double getTextWidth({
    required TextStyle textStyle,
  }) {
    return TextPainter.computeWidth(
      text: TextSpan(text: this, style: textStyle),
      textDirection: TextDirection.ltr,
    );
  }

  String get getImageUrl //({bool? highQuality})
  {
    if ((Config.isProduction && Config.isReleaseMode) || !Config.isWeb) {
      final url = Config.isWeb ? Uri.base.origin : 'https://veteranam.info';
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
  // : '/cdn-cgi/image/${Config.isWeb ? 'quality=100' : 'quality=85'}'
  //     ',width=${widget.size! * 10},${widget.size! * 10}/';
}

extension TranslateModelExtension on TranslateModel {
  String getTrsnslation(
    BuildContext context,
  ) =>
      context.isEnglish ? en ?? uk : uk;
}

extension ContextExtensions on BuildContext {
  bool get isEnglish => read<LanguageCubit>().state.isEnglish;

  Future<void> onMobFeedback(UserFeedback feedback) async =>
      read<MobFeedbackBloc>().add(MobFeedbackEvent.send(feedback.screenshot));

  // void copyText(String text, String? href, String? title) =>
  //     read<UrlCubit>().copy(text);

  // void launchUrl(String? url) => read<UrlCubit>().launchUrl(url: url);
  // ignore: avoid_positional_boolean_parameters
  void emailDialogCloseEvent(bool? value) {
    if (!mounted) return;
    if (!(value ?? false)) {
      read<UserEmailFormBloc>().add(
        const UserEmailFormEvent.sendEmailAfterClose(),
      );
    }
  }

  void copyEmail() => read<UrlCubit>().copy(
        KAppText.email,
      );

  @visibleForTesting
  static DateTime? pickerDate;

  Future<DateTime?> getDate({DateTime? currecntDate}) async =>
      pickerDate ??
      showDatePicker(
        context: this,
        initialDate: currecntDate ??
            ExtendedDateTime.current.add(
              const Duration(days: KDimensions.minAmountTimeDiscountDays),
            ),
        firstDate: ExtendedDateTime.current
            .add(const Duration(days: KDimensions.minAmountTimeDiscountDays)),
        lastDate: ExtendedDateTime.current.add(
          const Duration(days: 365 * 4),
        ),
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
  TranslateModel get getValue {
    switch (this) {
      case CategoryEnum.all:
        return KAppText.categoryAll;
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
//     if (Config.isReleaseMode && Config.isProduction) {
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

extension DiscountStateExtention on DiscountState {
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

extension CompanyModelExtensions on CompanyModel {
  String? get imageUrl => image?.downloadURL;
}

extension PlatformEnumFlutter on PlatformEnum {
  static bool get isWebDesktop => _isWebDesktop;
  @visibleForTesting
  static set isWebDesktop(bool isWebDesktop) => _isWebDesktop = isWebDesktop;

  // static bool _isWebMobile = Config.isWeb &&
  //     (defaultTargetPlatform == TargetPlatform.android ||
  //         defaultTargetPlatform == TargetPlatform.iOS);
  static bool _isWebDesktop = Config.isWeb &&
      (defaultTargetPlatform == TargetPlatform.fuchsia ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows);
}

extension ReasonComplaintFlutter on ReasonComplaint {
  String toText(BuildContext context) {
    switch (this) {
      case ReasonComplaint.fakeNewsOrDisinformation:
        return context.l10n.fakeNewsOrDisinformation;
      case ReasonComplaint.fraudOrSpam:
        return context.l10n.fraudOrSpam;
      case ReasonComplaint.offensiveOrHatefulContent:
        return context.l10n.offensiveOrHatefulContent;
      case ReasonComplaint.other:
        return context.l10n.other;
    }
  }
}

extension SubLocationString on SubLocation {
  List<String> getList(BuildContext context) {
    switch (this) {
      // case null:
      //   return [];
      case SubLocation.all:
      case SubLocation.allStoresOfChain:
      case SubLocation.online:
        return [context.l10n.allUkraine];
    }
  }

  String getFilterText(BuildContext context) {
    switch (this) {
      // case null:
      //   return [];
      case SubLocation.all:
      case SubLocation.allStoresOfChain:
      case SubLocation.online:
        return context.l10n.allUkraine;
    }
  }

  List<TranslateModel> getCardList(BuildContext context) {
    switch (this) {
      case SubLocation.all:
        return [KAppText.allStoresOfChain, KAppText.allUkrainOnline];
      case SubLocation.allStoresOfChain:
        return [KAppText.allStoresOfChain];
      case SubLocation.online:
        return [KAppText.allUkrainOnline];
    }
  }
}

extension WidgetStatePropertyExtension on WidgetStateProperty<dynamic> {
  static WidgetStateProperty<MouseCursor?> get buttonMouseCursor =>
      WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return SystemMouseCursors.forbidden;
        }
        return SystemMouseCursors.click;
      });
}
