import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class MobNavigationWidget extends StatelessWidget {
  const MobNavigationWidget({required this.index, super.key});
  final int index;

  @override
  Widget build(BuildContext context) {
    final route = [
      KRoute.discounts.name,
      KRoute.investors.name,
      KRoute.home.name,
    ];
    return BottomNavigationBar(
      key: KWidgetkeys.widget.mobNavigation.widget,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          key: KWidgetkeys.widget.mobNavigation.discounts,
          icon: KIcon.tag.copyWith(fill: 1),
          label: context.l10n.discounts,
        ),
        BottomNavigationBarItem(
          key: KWidgetkeys.widget.mobNavigation.investors,
          icon: KIcon.investors.copyWith(fill: 1),
          label: context.l10n.investors,
        ),
        BottomNavigationBarItem(
          key: KWidgetkeys.widget.mobNavigation.settings,
          icon: KIcon.settings.copyWith(fill: 1),
          label: context.l10n.settings,
        ),
      ],
      currentIndex: index,
      onTap: (i) => context.goNamed(route.elementAt(i)),
    );
  }
}
