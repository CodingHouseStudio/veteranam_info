part of '../widget_keys.dart';

abstract class MobNavigationKeys {
  static const widget = Key('mob_navigation');
  static const discounts = Key('mob_navigation_discounts');
  static const investors = Key('mob_navigation_investors');
  static const settings = Key('mob_navigation_settings');
  static const login = Key('mob_navigation_login');

  static const navButtonsKey = [
    discounts,
    investors,
    settings,
    login,
  ];
}
