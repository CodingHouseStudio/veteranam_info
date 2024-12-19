import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    required this.title,
    required this.titleKey,
    required this.subtitle,
    required this.subtitleKey,
    required this.isDesk,
    super.key,
  });

  final String title;
  final Key titleKey;
  final String subtitle;
  final Key subtitleKey;
  final bool isDesk;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          key: titleKey,
          style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
        ),
        KSizedBox.kHeightSizedBox8,
        Text(
          subtitle,
          key: subtitleKey,
          style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
        ),
      ],
    );
  }
}

class TitleIconWidget extends StatelessWidget {
  const TitleIconWidget({
    required this.title,
    required this.titleKey,
    required this.isDesk,
    required this.titleSecondPart,
    this.iconCrossAxisAlignment = CrossAxisAlignment.end,
    super.key,
  });
  final String title;
  final Key titleKey;
  final bool isDesk;
  final String titleSecondPart;
  // bool isRightArrow = true;
  final CrossAxisAlignment iconCrossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isDesk)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IconWidget(
                // key: KWidgetkeys.screen.feedback.titleIcon,
                icon: KIcon.arrowDownRight,
              ),
              KSizedBox.kWidthSizedBox90,
              Expanded(
                child: Column(
                  key: titleKey,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.materialThemeDisplayLarge,
                    ),
                    Text(
                      titleSecondPart,
                      style: AppTextStyle.materialThemeDisplayLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          )
        else ...[
          Row(
            key: titleKey,
            crossAxisAlignment: iconCrossAxisAlignment,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  '$title $titleSecondPart',
                  style: AppTextStyle.materialThemeDisplaySmall,
                ),
              ),
              IconWidget(
                // key: KWidgetkeys.screen.feedback.titleIcon,
                icon: KIcon.arrowDownLeft,
                padding:
                    isDesk ? KPadding.kPaddingSize20 : KPadding.kPaddingSize12,
              ),
            ],
          ),
        ],
        KSizedBox.kHeightSizedBox32,
        const Divider(
          color: AppColors.materialThemeKeyColorsNeutral,
        ),
      ],
    );
  }
}

class LineTitleIconWidget extends StatelessWidget {
  const LineTitleIconWidget({
    required this.title,
    required this.titleKey,
    required this.isDesk,
    this.iconCrossAxisAlignment = CrossAxisAlignment.end,
    super.key,
    this.rightWidget,
  });
  final String title;
  final Key titleKey;
  final bool isDesk;
  final Widget? rightWidget;
  final CrossAxisAlignment iconCrossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // if (isDesk)
        if (rightWidget == null)
          leftWidget
        else
          Row(
            children: [Expanded(child: leftWidget), rightWidget!],
          ),
        // else
        //   Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const IconWidget(
        //         // key: KWidgetkeys.screen.feedback.titleIcon,
        //         icon: KIcon.arrowDownRight,
        //       ),
        //       KSizedBox.kWidthSizedBox16,
        //       Expanded(
        //         child: Text(
        //           title,
        //           style: AppTextStyle.materialThemeDisplaySmall,
        //         ),
        //       ),
        //     ],
        //   ),
        KSizedBox.kHeightSizedBox32,
        const Divider(
          color: AppColors.materialThemeKeyColorsNeutral,
        ),
      ],
    );
  }

  Widget get leftWidget => Align(
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                title,
                key: titleKey,
                style: isDesk
                    ? AppTextStyle.materialThemeDisplayLarge
                    : AppTextStyle.materialThemeDisplaySmall,
              ),
            ),
            if (isDesk)
              KSizedBox.kWidthSizedBox32
            else
              KSizedBox.kWidthSizedBox24,
            IconWidget(
              // key: KWidgetkeys.screen.feedback.titleIcon,
              padding: isDesk ? null : KPadding.kPaddingSize8,
              icon: isDesk ? KIcon.arrowDownRight : KIcon.arrowDownLeft,
            ),
          ],
        ),
      );
}

/// A widget that displays a title with an optional second part, aligned icons,
/// and different layouts based on the screen size.
/// The widget adapts between a `Column` layout for desktop screens
/// and a `Row` layout for smaller screens,
/// with options for customizing text alignment, padding, and icon direction.

class TitlePointWidget extends StatelessWidget {
  const TitlePointWidget({
    required this.title,
    required this.titleSecondPart,
    required this.titleKey,
    required this.isDesk,
    super.key,
    this.titleSecondPartPadding = EdgeInsets.zero,
    this.isRightArrow = true,
    this.titleAlignment = WrapAlignment.start,
    this.iconCrossAxisAlignment = CrossAxisAlignment.start,
    this.textAlign = TextAlign.start,
  });

  /// The primary title text displayed in the widget.
  final String title;

  /// The secondary part of the title displayed in a separate text widget,
  /// with optional padding.
  final String titleSecondPart;

  /// A unique key for identifying the title widget.
  final Key titleKey;

  /// A boolean indicating if the widget is displayed on a desktop screen.
  /// When `true`, a column layout is used; otherwise, a row layout is used.
  final bool isDesk;

  /// Padding for the second part of the title text.
  final EdgeInsets titleSecondPartPadding;

  /// A boolean to determine the direction of the icon.
  /// When `true`, displays a right-pointing arrow; otherwise,
  /// a left-pointing arrow.
  final bool isRightArrow;

  /// The alignment for wrapping the secondary title
  /// and icon in the column layout.
  final WrapAlignment titleAlignment;

  /// Cross-axis alignment for the icon in the row layout.
  final CrossAxisAlignment iconCrossAxisAlignment;

  /// Text alignment for both the primary and secondary title texts.
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isDesk)
          Column(
            key: titleKey,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Displays the main title in the column layout,
              /// with specified text alignment.
              Text(
                title,
                textAlign: textAlign,
                style: AppTextStyle.materialThemeDisplayLarge,
              ),
              Padding(
                padding: titleSecondPartPadding,
                child: Wrap(
                  alignment: titleAlignment,
                  children: [
                    /// Displays the second part of the title text
                    /// in the column layout.
                    Text(
                      titleSecondPart,
                      style: AppTextStyle.materialThemeDisplayLarge,
                      textAlign: textAlign,
                    ),
                    KSizedBox.kWidthSizedBox24,

                    /// Displays an icon based on `isRightArrow`,
                    /// with the right or left direction.
                    IconWidget(
                      icon: isRightArrow
                          ? KIcon.arrowDownRight
                          : KIcon.arrowDownLeft,
                    ),
                  ],
                ),
              ),
            ],
          )
        else
          Row(
            key: titleKey,
            crossAxisAlignment: iconCrossAxisAlignment,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  '$title $titleSecondPart',
                  style: AppTextStyle.materialThemeDisplaySmall,
                ),
              ),

              /// Displays the icon next to the title in the row layout, with
              /// padding based on screen size.
              IconWidget(
                icon: isRightArrow ? KIcon.arrowDownRight : KIcon.arrowDownLeft,
                padding:
                    isDesk ? KPadding.kPaddingSize20 : KPadding.kPaddingSize12,
              ),
            ],
          ),

        /// Spacer and divider below the content to separate the widget visually
        KSizedBox.kHeightSizedBox32,
        const Divider(
          color: AppColors.materialThemeKeyColorsNeutral,
        ),
      ],
    );
  }
}

class ShortTitleIconWidget extends StatelessWidget {
  const ShortTitleIconWidget({
    required this.title,
    required this.titleKey,
    required this.isDesk,
    this.iconCrossAxisAlignment = CrossAxisAlignment.end,
    this.firstIcon = false,
    this.icon,
    super.key,
    this.expanded = false,
    this.titleAlign,
    this.mainAxisAlignment,
  });
  final String title;
  final Key titleKey;
  final bool isDesk;
  final CrossAxisAlignment iconCrossAxisAlignment;
  final bool expanded;
  final Icon? icon;
  final bool firstIcon;
  final TextAlign? titleAlign;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    if (expanded) {
      return Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _getList,
      );
    } else {
      return Wrap(
        alignment: mainAxisAlignment == MainAxisAlignment.center
            ? WrapAlignment.center
            : WrapAlignment.start,
        children: _getList,
      );
    }
  }

  List<Widget> get _getList => [
        if (firstIcon) ...[
          iconWidget,
          if (!expanded) spacerGet,
        ],
        if (expanded) Expanded(child: text) else text,
        if (!expanded) spacerGet,
        if (!firstIcon) iconWidget,
      ];

  Widget get spacerGet {
    if (isDesk) {
      return KSizedBox.kWidthSizedBox32;
    } else {
      if (firstIcon) {
        return KSizedBox.kWidthSizedBox16;
      } else {
        return KSizedBox.kWidthSizedBox24;
      }
    }
  }

  Widget get text => Text(
        title,
        key: titleKey,
        style: isDesk
            ? AppTextStyle.materialThemeDisplayLarge
            : AppTextStyle.materialThemeDisplaySmall,
        textAlign: titleAlign,
      );

  Widget get iconWidget => IconWidget(
        icon: icon ?? KIcon.arrowDownLeft,
        padding: isDesk ? KPadding.kPaddingSize20 : KPadding.kPaddingSize8,
      );
}

class LineTitleIconButtonWidget extends StatelessWidget {
  const LineTitleIconButtonWidget({
    required this.title,
    required this.titleKey,
    required this.icon,
    required this.iconButtonKey,
    required this.isDesk,
    this.onPressed,
    super.key,
  });
  final String title;
  final Key titleKey;
  final Key iconButtonKey;
  final bool isDesk;
  final Icon icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: titleKey,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: isDesk
                ? AppTextStyle.materialThemeDisplayLarge
                : AppTextStyle.materialThemeDisplaySmall,
          ),
        ),
        IconButtonWidget(
          key: iconButtonKey,
          padding: isDesk ? KPadding.kPaddingSize20 : KPadding.kPaddingSize12,
          icon: icon,
          background: AppColors.materialThemeKeyColorsPrimary,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
