import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> storyCardHelper({
  required WidgetTester tester,
  String? image,
}) async {
  expect(find.byKey(KWidgetkeys.widget.storyCard.date), findsWidgets);

  expect(
    find.byKey(KWidgetkeys.widget.storyCard.userIcon),
    findsWidgets,
  );

  // expect(find.byKey(KWidgetkeys.widget.storyCard.trashIcon), findsWidgets);

  expect(
    find.byKey(KWidgetkeys.widget.storyCard.userName),
    findsWidgets,
  );

  if (image != null) {
    await cardAddImageHelper(tester: tester, image: image);
  } else {
    await cardTextDetailEvaluateHelper(tester: tester);
  }
}
