import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class MobNavigationWidget extends StatelessWidget {
  const MobNavigationWidget({required this.index, super.key});
  final int index;

  @override
  Widget build(BuildContext context) {
    final routes = [
      KRoute.discounts.name,
      KRoute.investors.name,
      KRoute.home.name,
    ];

    final icons = [
      KIcon.tag,
      KIcon.briefcase,
      KIcon.settings,
    ];

    final labels = [
      context.l10n.discounts,
      context.l10n.investors,
      context.l10n.settings,
    ];

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(KSize.kPixel32),
        topRight: Radius.circular(KSize.kPixel32),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: KSize.kPixel80),
        child: BottomNavigationBar(
          key: KWidgetkeys.widget.mobNavigation.widget,
          items: List.generate(icons.length, (index) {
            return BottomNavigationBarItem(
              key: KWidgetkeys.widget.mobNavigation.navButtonsKey[index],
              icon: Padding(
                padding: const EdgeInsets.only(bottom: KPadding.kPaddingSize8),
                child: icons[index],
              ),
              activeIcon: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.materialThemeKeyColorsPrimary,
                ),
                padding: const EdgeInsets.all(KPadding.kPaddingSize8),
                child: icons[index],
              ),
              label: labels[index],
            );
          }),
          backgroundColor: AppColors.materialThemeKeyColorsNeutral,
          unselectedLabelStyle: AppTextStyle.materialThemeLabelSmall,
          selectedLabelStyle: AppTextStyle.materialThemeLabelSmall,
          currentIndex: index,
          onTap: (i) => context.goNamed(routes[i]),
        ),
      ),
    );
  }
}
