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
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: KSize.kPixel60),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: KIcon.tag,
            label: context.l10n.discounts,
          ),
          BottomNavigationBarItem(
            icon: KIcon.briefcase,
            label: context.l10n.investors,
          ),
          BottomNavigationBarItem(
            icon: KIcon.settings,
            label: context.l10n.settings,
          ),
        ],
        unselectedLabelStyle: AppTextStyle.materialThemeLabelSmall,
        selectedLabelStyle: AppTextStyle.materialThemeLabelSmall,
        currentIndex: index,
        onTap: (i) => context.goNamed(route.elementAt(i)),
      ),
    );
  }
}
