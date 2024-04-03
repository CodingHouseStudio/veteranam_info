part of '../widget_keys.dart';

class _ScreenKeys {
  final home = _HomeKeys();
  final app = _AppKeys();
  final discounts = _DiscountsKeys();
  final information = _InformationKeys();
  final investors = _InvestorsKeys();
  final profile = _ProfileKeys();
  final story = _StoryKeys();
  final work = _WorkKeys();
  final error = _ErrorKeys();

  List<List<Key?>> get screens => [
        [
          null, //about_us_screen
          investors.screen,
          null, //contact_screen
        ],
        [
          story.screen,
          discounts.screen,
          profile.screen,
        ],
        [
          work.screen,
          information.screen,
          null, //consultation_online_screen
        ],
      ];
}
