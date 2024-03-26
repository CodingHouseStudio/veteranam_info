// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

part 'home.dart';
part 'app.dart';
part 'discounts.dart';
part 'information.dart';
part 'investors.dart';
part 'profile.dart';
part 'story.dart';
part 'work.dart';

abstract class KWIdgetkeys {
  static _HomeKeys get homeKeys => _HomeKeys();
  static _AppKeys get appKeys => _AppKeys();
  static _DiscountsKeys get discountsKeys => _DiscountsKeys();
  static _InformationKeys get informationKeys => _InformationKeys();
  static _InvestorsKeys get investorsKeys => _InvestorsKeys();
  static _ProfileKeys get profileKeys => _ProfileKeys();
  static _StoryKeys get storyKeys => _StoryKeys();
  static _WorkKeys get workKeys => _WorkKeys();
}
