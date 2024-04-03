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
    itemKey: KWidgetkeys.widget.footer.storyButton,
  );

  expect(
    find.byKey(KWidgetkeys.widget.footer.storyButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.footer.storyButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.story.screen),
    findsOneWidget,
  );
}
