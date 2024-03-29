import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> dropListFieldBoxHelper({
  required WidgetTester tester,
  required String dropListitem,
}) async {
  expect(find.byKey(KWidgetkeys.dropListFieldKeys.widget), findsOneWidget);

  expect(find.byKey(KWidgetkeys.dropListFieldKeys.field), findsOneWidget);

  expect(find.byKey(KWidgetkeys.dropListFieldKeys.list), findsNothing);

  expect(find.byKey(KWidgetkeys.dropListFieldKeys.items), findsNothing);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.dropListFieldKeys.list),
      matching: find.text(dropListitem),
    ),
    findsNothing,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.dropListFieldKeys.field),
  );
  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.dropListFieldKeys.list), findsOneWidget);

  expect(find.byKey(KWidgetkeys.dropListFieldKeys.items), findsWidgets);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.dropListFieldKeys.list),
      matching: find.text(dropListitem),
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.descendant(
      of: find.byKey(KWidgetkeys.dropListFieldKeys.list),
      matching: find.text(dropListitem),
    ),
  );

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.dropListFieldKeys.list), findsNothing);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.dropListFieldKeys.widget),
      matching: find.text(dropListitem),
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.dropListFieldKeys.field),
  );
  await tester.pumpAndSettle();

  await tester.enterText(
    find.byKey(KWidgetkeys.dropListFieldKeys.field),
    dropListitem,
  );
  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.dropListFieldKeys.widget),
      matching: find.text(dropListitem),
    ),
    findsWidgets,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.dropListFieldKeys.field),
    '${dropListitem}a',
  );
  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.dropListFieldKeys.widget),
      matching: find.text(dropListitem),
    ),
    findsNothing,
  );
}
