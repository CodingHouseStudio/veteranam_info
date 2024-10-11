import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class MobNavigationWidget extends StatelessWidget {
  const MobNavigationWidget({required this.index, super.key});
  final int index;

  @override
  Widget build(BuildContext context) {
    final labels = [
      context.l10n.discounts,
      context.l10n.investors,
      context.l10n.settings,
    ];

    return DecoratedBox(
      decoration: const BoxDecoration(
        boxShadow: KWidgetTheme.boxShadow,
      ),
      child: ClipRRect(
        borderRadius: KBorderRadius.kBorderRadiusTop32,
        clipBehavior: Clip.hardEdge,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: KSize.kPixel80),
          child: BottomNavigationBar(
            key: KWidgetkeys.widget.mobNavigation.widget,
            items: List.generate(KIcon.icons.length, (index) {
              return BottomNavigationBarItem(
                key: KWidgetkeys.widget.mobNavigation.navButtonsKey[index],
                icon: Padding(
                  padding:
                      const EdgeInsets.only(bottom: KPadding.kPaddingSize8),
                  child: KIcon.icons[index],
                ),
                activeIcon: IconWidget(
                  icon: KIcon.icons[index],
                  background: AppColors.materialThemeKeyColorsPrimary,
                  padding: KPadding.kPaddingSize8,
                ),
                label: labels[index],
              );
            }),
            backgroundColor: AppColors.materialThemeKeyColorsNeutral,
            selectedLabelStyle: AppTextStyle.materialThemeLabelSmall,
            unselectedLabelStyle: AppTextStyle.materialThemeLabelSmall,
            currentIndex: index,
            onTap: (i) => context.goNamed(KAppText.routes[i]),
          ),
        ),
      ),
    );
  }
}
