import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

abstract class SectionWidget {
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
