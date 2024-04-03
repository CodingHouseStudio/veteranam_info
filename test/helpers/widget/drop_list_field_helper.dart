import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> dropListFieldBoxHelper({
  required WidgetTester tester,
  required String dropListitem,
}) async {
  expect(
    find.byKey(KWidgetkeys.widgetKeys.dropListFieldKeys.widget),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.dropListFieldKeys.field),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.dropListFieldKeys.list),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.dropListFieldKeys.items),
    findsNothing,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widgetKeys.dropListFieldKeys.list),
      matching: find.text(dropListitem),
    ),
    findsNothing,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widgetKeys.dropListFieldKeys.field),
  );
  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widgetKeys.dropListFieldKeys.list),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.dropListFieldKeys.items),
    findsWidgets,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widgetKeys.dropListFieldKeys.list),
      matching: find.text(dropListitem),
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.descendant(
      of: find.byKey(KWidgetkeys.widgetKeys.dropListFieldKeys.list),
      matching: find.text(dropListitem),
    ),
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widgetKeys.dropListFieldKeys.list),
    findsNothing,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widgetKeys.dropListFieldKeys.widget),
      matching: find.text(dropListitem),
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widgetKeys.dropListFieldKeys.field),
  );
  await tester.pumpAndSettle();

  await tester.enterText(
    find.byKey(KWidgetkeys.widgetKeys.dropListFieldKeys.field),
    dropListitem,
  );
  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widgetKeys.dropListFieldKeys.widget),
      matching: find.text(dropListitem),
    ),
    findsWidgets,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.widgetKeys.dropListFieldKeys.field),
    '${dropListitem}a',
  );
  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widgetKeys.dropListFieldKeys.widget),
      matching: find.text(dropListitem),
    ),
    findsNothing,
  );
}
