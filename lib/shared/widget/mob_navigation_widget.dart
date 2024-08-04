import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class MobNavigationWidget extends StatelessWidget {
  const MobNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final route = [
      KRoute.discounts.name,
      KRoute.investors.name,
      KRoute.home.name,
    ];
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: KIcon.tag.copyWith(fill: 1),
          label: context.l10n.discounts,
        ),
        BottomNavigationBarItem(
          icon: KIcon.investors.copyWith(fill: 1),
          label: context.l10n.investors,
        ),
        BottomNavigationBarItem(
          icon: KIcon.settings.copyWith(fill: 1),
          label: context.l10n.settings,
        ),
      ],
      currentIndex: 2,
      onTap: (i) => context.goNamed(route.elementAt(i)),
    );
  }
}
