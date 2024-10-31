import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> questionHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.question.widget),
    findsWidgets,
  );

  expect(find.byKey(KWidgetkeys.widget.question.title), findsWidgets);

  expect(
    find.byKey(KWidgetkeys.widget.question.subtitle),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.question.iconPlus),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.question.iconMinus),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.question.title,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.question.title).first);

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.question.iconMinus),
    findsOneWidget,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.question.title).first,
      matching: find.byKey(KWidgetkeys.widget.question.iconPlus),
    ),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.question.subtitle),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.question.title).first);

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.question.iconMinus),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.question.subtitle),
    findsNothing,
  );
}
