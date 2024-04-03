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
    itemKey: KWidgetkeys.footerKeys.storyButton,
  );

  expect(find.byKey(KWidgetkeys.footerKeys.storyButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.footerKeys.storyButton));

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.storyScreenKeys.screen), findsOneWidget);
}
