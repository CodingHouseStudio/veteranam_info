// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

part 'widget/icons_area.dart';
part 'widget/search.dart';
part 'screen/home.dart';
part 'screen/app.dart';
part 'screen/discounts.dart';
part 'screen/information.dart';
part 'screen/investors.dart';
part 'screen/profile.dart';
part 'screen/story.dart';
part 'screen/work.dart';

abstract class KWidgetkeys {
  static _HomeKeys get homeKeys => _HomeKeys();
  static _AppKeys get appKeys => _AppKeys();
  static _DiscountsKeys get discountsKeys => _DiscountsKeys();
  static _InformationKeys get informationKeys => _InformationKeys();
  static _InvestorsKeys get investorsKeys => _InvestorsKeys();
  static _ProfileKeys get profileKeys => _ProfileKeys();
  static _StoryKeys get storyKeys => _StoryKeys();
  static _WorkKeys get workKeys => _WorkKeys();

  static _SearchKeys get searchKeys => _SearchKeys();
  static _IconsAreaKeys get iconsAreKeys => _IconsAreaKeys();
}
