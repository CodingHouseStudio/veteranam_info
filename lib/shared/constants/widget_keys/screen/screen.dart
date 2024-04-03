part of '../widget_keys.dart';

class _ScreenKeys {
  final homeScreenKeys = _HomeKeys();
  final appScreenKeys = _AppKeys();
  final discountsScreenKeys = _DiscountsKeys();
  final informationScreenKeys = _InformationKeys();
  final investorsScreenKeys = _InvestorsKeys();
  final profileScreenKeys = _ProfileKeys();
  final storyScreenKeys = _StoryKeys();
  final workScreenKeys = _WorkKeys();
  final errorScreenKeys = _ErrorKeys();

  List<List<Key?>> get screensKey => [
        [
          null, //about_us_screen
          investorsScreenKeys.screen,
          null, //contact_screen
        ],
        [
          storyScreenKeys.screen,
          discountsScreenKeys.screen,
          profileScreenKeys.screen,
        ],
        [
          workScreenKeys.screen,
          informationScreenKeys.screen,
          null, //consultation_online_screen
        ],
      ];
}
