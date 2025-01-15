import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({
    required this.isSelected,
    required this.onChanged,
    super.key,
  });
  final bool isSelected;
  final void Function()? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      key: SwitchKeys.widget,
      value: isSelected,
      onChanged: (value) => onChanged?.call(),
      trackColor: const WidgetStatePropertyAll(
        AppColors.materialThemeKeyColorsNeutralVariant,
      ),
      trackOutlineWidth: const WidgetStatePropertyAll(0),
      trackOutlineColor: const WidgetStatePropertyAll(
        AppColors.materialThemeKeyColorsNeutralVariant,
      ),
      thumbColor: WidgetStatePropertyAll(
        isSelected
            ? AppColors.materialThemeKeyColorsSecondary
            : AppColors.materialThemeWhite,
      ),
    );
    // return IconButton(
    //   key: SwitchKeys.widget,
    //   style: KButtonStyles.withoutStyle,
    //   onPressed: onChanged,
    //   icon: DecoratedBox(
    //     decoration: KWidgetTheme.boxDecorationNawbar,
    //     child: AnimatedContainer(
    //       duration: const Duration(milliseconds: 200),
    //       // key: SwitchKeys.item,
    //       constraints: const BoxConstraints(
    //         minWidth: KSize.kPixel40,
    //         minHeight: KSize.kPixel40,
    //       ),
    //       decoration: isSelected
    //           ? KWidgetTheme.boxDecorationBlackCircular.copyWith(
    //               color: onChanged == null
    //                   ? AppColors.
    // materialThemeRefNeutralVariantNeutralVariant70
    //                   : null,
    //             )
    //           : KWidgetTheme.boxDecorationWhiteCircular,
    //       margin: EdgeInsets.only(
    //         top: KPadding.kPaddingSize4,
    //         bottom: KPadding.kPaddingSize4,
    //         left: horizontalMergin(isRight: false),
    //         right: horizontalMergin(isRight: true),
    //       ),
    //       padding: const EdgeInsets.all(
    //         KPadding.kPaddingSize8,
    //       ),
    //       child: KIcon.modeOffOn.copyWith(
    //         key: isSelected ? SwitchKeys.active : null,
    //         color: isSelected
    //             ? onChanged == null
    //                 ? AppColors.materialThemeKeyColorsNeutral
    //                 : AppColors.materialThemeWhite
    //             : onChanged == null
    //                 ? AppColors.materialThemeRefNeutralNeutral70
    //                 : AppColors.materialThemeKeyColorsSecondary,
    //       ),
    //     ),
    //   ),
    // );
  }

  // double horizontalMergin({required bool isRight}) => isRight
  //     ? isSelected
  //         ? KPadding.kPaddingSize4
  //         : KPadding.kPaddingSize52
  //     : isSelected
  //         ? KPadding.kPaddingSize52
  //         : KPadding.kPaddingSize4;
}
