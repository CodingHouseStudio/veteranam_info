import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> multiDropFieldHelper({
  required WidgetTester tester,
  required String text,
}) async {
  await dropListFieldHelper(tester: tester, text: text);

  expect(find.byKey(KWidgetkeys.widget.multiDropField.chips), findsOneWidget);

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropListField.field),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byType(MenuItemButton).first,
  );

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.multiDropField.chips), findsOneWidget);

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropListField.field),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byType(MenuItemButton).at(1),
  );

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.multiDropField.chips), findsWidgets);

  await tester.tap(find.byKey(KWidgetkeys.widget.multiDropField.chips).first);

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.multiDropField.chips), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.widget.multiDropField.chips));

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.multiDropField.chips), findsNothing);
}
