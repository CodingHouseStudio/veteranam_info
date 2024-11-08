import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({
    required this.isDesk,
    required this.route,
    required this.title,
    required this.subtitle,
    required this.textButton,
    required this.titleKey,
    required this.subtitleKey,
    required this.buttonKey,
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.bottomWidget,
  });
  final bool isDesk;
  final CrossAxisAlignment crossAxisAlignment;
  final void Function() route;
  final String title;
  final String subtitle;
  final String textButton;
  final Key titleKey;
  final Key subtitleKey;
  final Key buttonKey;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: get(
        isTablet: isDesk,
        // textPoint: null,
        title: title,
        subtitle: subtitle,
        textButton: textButton,
        route: route,
        // prefixKey: null,
        titleKey: titleKey,
        subtitleKey: subtitleKey,
        buttonKey: buttonKey,
        bottomWidget: bottomWidget,
      ),
    );
  }

  static List<Widget> get({
    required bool isTablet,
    // required String? textPoint,
    required String title,
    required String subtitle,
    required String textButton,
    required void Function()? route,
    // required Key? prefixKey,
    required Key titleKey,
    required Key subtitleKey,
    required Key buttonKey,
    Widget? bottomWidget,
  }) =>
      [
        // if (textPoint != null) ...[
        //   TextPointWidget(
        //     textPoint,
        //     key: prefixKey,
        //   ),
        //   if (isTablet)
        //     KSizedBox.kHeightSizedBox16
        //   else
        //     KSizedBox.kHeightSizedBox8,
        // ],
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            key: titleKey,
            style: isTablet
                ? AppTextStyle.materialThemeDisplayLarge
                : isTablet
                    ? AppTextStyle.materialThemeDisplayMedium
                    : AppTextStyle.materialThemeDisplaySmall,
          ),
        ),
        if (isTablet)
          KSizedBox.kHeightSizedBox16
        else
          KSizedBox.kHeightSizedBox8,
        Text(
          subtitle,
          key: subtitleKey,
          style: isTablet
              ? AppTextStyle.materialThemeBodyLarge
              : AppTextStyle.materialThemeBodyMedium,
        ),
        if (isTablet)
          KSizedBox.kHeightSizedBox16
        else
          KSizedBox.kHeightSizedBox8,
        DoubleButtonWidget(
          widgetKey: buttonKey,
          text: textButton,
          onPressed: route,
          isDesk: isTablet,
        ),
        if (bottomWidget != null) bottomWidget,
      ];
}
