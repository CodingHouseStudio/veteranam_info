import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class AdvancedFilterButton extends StatelessWidget {
  const AdvancedFilterButton({
    required this.isDesk,
    this.onPressed,
    super.key,
  });
  final bool isDesk;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: isDesk
          ? _buildAdvancedFilterRow(context, isDesk)
          : TextButton.icon(
              key: KWidgetkeys.screen.discounts.advancedFilterButton,
              style: KButtonStyles.advancedButtonStyle,
              label: _buildAdvancedFilterRow(context, isDesk),
              // KSizedBox.kWidthSizedBox8,
              icon: const IconWidget(
                icon: KIcon.tune,
                background: AppColors.materialThemeKeyColorsNeutral,
                padding: KPadding.kPaddingSize12,
              ),
              onPressed: onPressed,
              //if (isDesk) KIcon.meil,
            ),

      // KSizedBox.kWidthSizedBox8,
    );
  }
}

Widget _buildAdvancedFilterRow(BuildContext context, bool isDesk) {
  return Row(
    key: isDesk ? KWidgetkeys.screen.discounts.advancedFilterButton : null,
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
    ],
  );
}
