import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    required this.route,
    required this.index,
    super.key,
  });

  final List<String> route;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(KSize.kPixel32),
        topRight: Radius.circular(KSize.kPixel32),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: KSize.kPixel80),
        child: BottomNavigationBar(
          backgroundColor: AppColors.materialThemeKeyColorsNeutral,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _buildIcon(KIcon.tag, 0),
              label: context.l10n.discounts,
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(KIcon.briefcase, 1),
              label: context.l10n.investors,
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(KIcon.settings, 2),
              label: context.l10n.settings,
            ),
          ],
          unselectedLabelStyle: AppTextStyle.materialThemeLabelSmall,
          selectedLabelStyle: AppTextStyle.materialThemeLabelSmall,
          currentIndex: index,
          onTap: (i) => context.goNamed(route.elementAt(i)),
        ),
      ),
    );
  }

  Widget _buildIcon(Widget icon, int itemIndex) {
    return index == itemIndex
        ? Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.materialThemeKeyColorsPrimary,
            ),
            padding: const EdgeInsets.all(KPadding.kPaddingSize8),
            child: icon,
          )
        : Padding(
            padding: const EdgeInsets.only(bottom: KPadding.kPaddingSize8),
            child: icon,
          );
  }
}
