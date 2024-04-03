import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../helper.dart';

Future<void> footerStoryRoutHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
  );
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widgetKeys.footerKeys.storyButton,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.footerKeys.storyButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widgetKeys.footerKeys.storyButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screenKeys.storyScreenKeys.screen),
    findsOneWidget,
  );
}
