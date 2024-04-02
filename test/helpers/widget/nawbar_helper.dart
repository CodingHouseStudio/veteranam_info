import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../helpers.dart';

Future<void> nawbarHelper({
  required WidgetTester tester,
  required String searchText,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
  );

  expect(find.byKey(KWidgetkeys.nawbarKeys.title), findsOneWidget);

  expect(find.byKey(KWidgetkeys.nawbarKeys.field), findsOneWidget);

  expect(find.byKey(KWidgetkeys.nawbarKeys.iconMic), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.nawbarKeys.button),
    findsOneWidget,
  );

  expect(find.byKey(KWidgetkeys.nawbarKeys.iconPerson), findsOneWidget);

  await tester.enterText(find.byKey(KWidgetkeys.nawbarKeys.field), searchText);

  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.nawbarKeys.field),
      matching: find.text(searchText),
    ),
    findsOneWidget,
  );

  expect(find.byKey(KWidgetkeys.nawbarKeys.iconPerson), findsOneWidget);
  expect(find.byKey(KWidgetkeys.nawbarKeys.title), findsOneWidget);

  await changeWindowSizeHelper(tester: tester, setDefaultSize: true);

  final textField = tester.widget<TextField>(
    find.byKey(
      KWidgetkeys.nawbarKeys.field,
    ),
  );
  textField.focusNode?.unfocus();

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.nawbarKeys.title), findsOneWidget);

  expect(find.byKey(KWidgetkeys.nawbarKeys.field), findsOneWidget);

  expect(find.byKey(KWidgetkeys.nawbarKeys.iconMic), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.nawbarKeys.button),
    findsNothing,
  );

  expect(find.byKey(KWidgetkeys.nawbarKeys.iconPerson), findsOneWidget);

  await tester.enterText(find.byKey(KWidgetkeys.nawbarKeys.field), searchText);

  await tester.pumpAndSettle();
  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.nawbarKeys.field),
      matching: find.text(searchText),
    ),
    findsOneWidget,
  );

  expect(find.byKey(KWidgetkeys.nawbarKeys.title), findsNothing);
  expect(find.byKey(KWidgetkeys.nawbarKeys.iconPerson), findsNothing);
}
