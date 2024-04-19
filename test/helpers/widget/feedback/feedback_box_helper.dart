import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> feedbackBoxHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.feedbackBox.button),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedbackBox.subtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedbackBox.title),
    findsOneWidget,
  );

  await boxHelper(tester);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.feedbackBox.button,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.feedbackBox.button));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.feedbackBox.button),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedbackBox.subtitle),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedbackBox.title),
    findsNothing,
  );

  await feedbackHelper(tester);
}
