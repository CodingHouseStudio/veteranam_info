part of '../widget_keys.dart';

class _ScreenKeys {
  List<List<Key?>> get screensKey => [
        [
          null, //about_us_screen
          _InvestorsKeys().screen,
          null, //contact_screen
        ],
        [
          _StoryKeys().screen,
          _DiscountsKeys().screen,
          _ProfileKeys().screen,
        ],
        [
          _WorkKeys().screen,
          _InformationKeys().screen,
          null, //consultation_online_screen
        ],
      ];
}
