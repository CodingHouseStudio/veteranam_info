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
  final aboutUs = _AboutUsKeys();
  final consultation = _ConsultationKeys();
  final contact = _ContactKeys();

  List<List<Key>> get screens => [
        [
          aboutUs.screen,
          investors.screen,
          contact.screen,
        ],
        [
          story.screen,
          discounts.screen,
          profile.screen,
        ],
        [
          work.screen,
          information.screen,
          consultation.screen,
        ],
      ];
}
