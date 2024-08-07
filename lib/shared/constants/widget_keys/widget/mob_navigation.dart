part of '../widget_keys.dart';

class _MobNavigationKeys {
  final widget = const Key('mob_navigation');
  final discounts = const Key('mob_navigation_discounts');
  final investors = const Key('mob_navigation_investors');
  final settings = const Key('mob_navigation_settings');

  List<Key> get buttonsKey => [
        settings,
        investors,
      ];

  List<Key> get navButtonsKey => [
        discounts,
        investors,
        settings,
      ];
}
