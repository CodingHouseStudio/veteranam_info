import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> storyCardHelper({
  required WidgetTester tester,
  String? image,
}) async {
  expect(find.byKey(KWidgetkeys.widgetKeys.storyCardKeys.date), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.widgetKeys.storyCardKeys.userIcon),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.storyCardKeys.userName),
    findsOneWidget,
  );

  if (image != null) {
    await cardAddImageHelper(tester: tester, image: image);
  } else {
    await cardTextDetailEvaluateHelper(tester: tester);
  }
}
