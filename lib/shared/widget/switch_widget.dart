import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({
    required this.isSelected,
    required this.onChanged,
    super.key,
  });
  final bool isSelected;
  // ignore: avoid_positional_boolean_parameters
  final void Function()? onChanged;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: KWidgetkeys.widget.switchKeys.widget,
      style: KButtonStyles.withoutStyle,
      onPressed: onChanged,
      icon: DecoratedBox(
        key: isSelected ? KWidgetkeys.widget.switchKeys.active : null,
        decoration: KWidgetTheme.boxDecorationNawbar,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            2,
            _switch,
          ),
        ),
      ),
    );
  }

  Widget _switch(int index) => Container(
        // key: KWidgetkeys.widget.switchKeys.item,
        constraints: const BoxConstraints(
          minWidth: KSize.kPixel40,
          minHeight: KSize.kPixel40,
        ),
        decoration: (isSelected && index == 0) || (!isSelected && index == 1)
            ? KWidgetTheme.boxDecorationGrayCircular
            : isSelected
                ? KWidgetTheme.boxDecorationBlackCircular.copyWith(
                    color: onChanged == null
                        ? AppColors
                            .materialThemeRefNeutralVariantNeutralVariant70
                        : null,
                  )
                : KWidgetTheme.boxDecorationWhiteCircular,
        margin: const EdgeInsets.all(KPadding.kPaddingSize4),
        padding: const EdgeInsets.all(
          KPadding.kPaddingSize8,
        ),
        child: (isSelected && index == 0) || (!isSelected && index == 1)
            ? KSizedBox.kWidthSizedBox24
            : KIcon.modeOffOn.copyWith(
                key: KWidgetkeys.widget.switchKeys.icon,
                color: isSelected
                    ? onChanged == null
                        ? AppColors.materialThemeKeyColorsNeutral
                        : AppColors.materialThemeWhite
                    : onChanged == null
                        ? AppColors.materialThemeRefNeutralNeutral70
                        : AppColors.materialThemeKeyColorsSecondary,
              ),
      );
}
