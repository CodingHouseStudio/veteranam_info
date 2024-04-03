// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

part 'screen/screen.dart';
part 'screen/home.dart';
part 'screen/app.dart';
part 'screen/discounts.dart';
part 'screen/information.dart';
part 'screen/investors.dart';
part 'screen/profile.dart';
part 'screen/story.dart';
part 'screen/work.dart';
part 'screen/error.dart';

part 'widget/question.dart';
part 'widget/nawbar.dart';
part 'widget/filter.dart';
part 'widget/drop_list_field.dart';
part 'widget/footer.dart';
part 'widget/message_field.dart';
part 'widget/story_card.dart';
part 'widget/box.dart';
part 'widget/card_text_detail.dart';
part 'widget/work_card.dart';
part 'widget/card_text_detail_evaluate.dart';
part 'widget/card_add_image.dart';
part 'widget/news_card.dart';
part 'widget/widget.dart';

abstract class KWidgetkeys {
  static _ScreenKeys get screenKeys => _ScreenKeys();
  static _WidgetKeys get widgetKeys => _WidgetKeys();
}
