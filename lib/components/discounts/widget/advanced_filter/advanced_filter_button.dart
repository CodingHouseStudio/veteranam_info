import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class AdvancedFilterButton extends StatelessWidget {
  const AdvancedFilterButton({
    required this.isDesk,
    required this.onPressed,
    super.key,
    this.icon,
  });
  final bool isDesk;
  final void Function() onPressed;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: isDesk
          ? Row(
              key: KWidgetkeys.screen.discounts.advancedFilterButton,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isDesk)
                  Expanded(
                    child: Text(
                      context.l10n.advancedFilter,
                      style: isDesk
                          ? AppTextStyle.materialThemeHeadlineSmall
                          : AppTextStyle.materialThemeTitleMedium,
                    ),
                  )
                else
                  Text(
                    context.l10n.advancedFilter,
                    style: isDesk
                        ? AppTextStyle.materialThemeHeadlineSmall
                        : AppTextStyle.materialThemeTitleMedium,
                  ),
                if (icon != null) ...[KSizedBox.kWidthSizedBox8, icon!],
                IconWidget(
                  icon: KIcon.tune,
                  background: AppColors.materialThemeKeyColorsNeutral,
                  padding: isDesk
                      ? KPadding.kPaddingSize20
                      : KPadding.kPaddingSize12,
                ),
              ],
            )
          : TextButton.icon(
              key: KWidgetkeys.screen.discounts.advancedFilterButton,
              style: KButtonStyles.advancedButtonStyle,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isDesk)
                    Expanded(
                      child: Text(
                        context.l10n.advancedFilter,
                        style: isDesk
                            ? AppTextStyle.materialThemeHeadlineSmall
                            : AppTextStyle.materialThemeTitleMedium,
                      ),
                    )
                  else
                    Text(
                      context.l10n.advancedFilter,
                      style: isDesk
                          ? AppTextStyle.materialThemeHeadlineSmall
                          : AppTextStyle.materialThemeTitleMedium,
                    ),
                  if (icon != null) ...[KSizedBox.kWidthSizedBox8, icon!],
                ],
              ),
              // KSizedBox.kWidthSizedBox8,
              icon: IconWidget(
                icon: KIcon.tune,
                background: AppColors.materialThemeKeyColorsNeutral,
                padding:
                    isDesk ? KPadding.kPaddingSize20 : KPadding.kPaddingSize12,
              ),
              onPressed: onPressed,
              //if (isDesk) KIcon.meil,
            ),

      // KSizedBox.kWidthSizedBox8,
    );
  }
}
