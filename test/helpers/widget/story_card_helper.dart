import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> storyCardHelper({
  required WidgetTester tester,
  String? image,
}) async {
  expect(find.byKey(StoryCardKeys.date), findsWidgets);

  expect(
    find.byKey(StoryCardKeys.userIcon),
    findsWidgets,
  );

  // expect(find.byKey(StoryCardKeys.trashIcon), findsWidgets);

  expect(
    find.byKey(StoryCardKeys.userName),
    findsWidgets,
  );

  if (image != null) {
    await cardAddImageHelper(tester: tester, image: image);
  } else {
    await cardTextDetailEvaluateHelper(tester: tester);
  }
}
