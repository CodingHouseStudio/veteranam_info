part of '../widget_keys.dart';

class _MobNavigationKeys {
  final widget = const Key('mob_navigation');
  final discounts = const Key('mob_navigation_discounts');
  final investors = const Key('mob_navigation_investors');
  final settings = const Key('mob_navigation_settings');
  final login = const Key('mob_navigation_login');

  List<Key> get navButtonsKey => [
        discounts,
        investors,
        login,
        settings,
      ];
}
