// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

part 'screen/home.dart';
part 'screen/app.dart';
part 'screen/discounts.dart';
part 'screen/information.dart';
part 'screen/investors.dart';
part 'screen/profile.dart';
part 'screen/story.dart';
part 'screen/work.dart';

part 'widget/question.dart';
part 'widget/nawbar.dart';
part 'widget/filter.dart';
part 'widget/footer.dart';
part 'widget/message_field.dart';

abstract class KWidgetkeys {
  static _HomeKeys get homeKeys => _HomeKeys();
  static _AppKeys get appKeys => _AppKeys();
  static _DiscountsKeys get discountsKeys => _DiscountsKeys();
  static _InformationKeys get informationKeys => _InformationKeys();
  static _InvestorsKeys get investorsKeys => _InvestorsKeys();
  static _ProfileKeys get profileKeys => _ProfileKeys();
  static _StoryKeys get storyKeys => _StoryKeys();
  static _WorkKeys get workKeys => _WorkKeys();

  static _NawbarKeys get nawbarKeys => _NawbarKeys();
  static _QuestionKeys get questionKeys => _QuestionKeys();
  static _FilterKeys get filterKeys => _FilterKeys();
  static _MessageFieldKeys get inputKeys => _MessageFieldKeys();
  static _FooterKeys get footerKeys => _FooterKeys();
}
