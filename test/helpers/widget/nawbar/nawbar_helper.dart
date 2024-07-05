import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> nawbarHelper({
  required WidgetTester tester,
  required String searchText,
}) async {
  await languageSwitcherHelper(tester);

  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      expect(find.byKey(KWidgetkeys.widget.nawbar.logo), findsOneWidget);

      expect(find.byKey(KWidgetkeys.widget.nawbar.field), findsOneWidget);

      // expect(
      //   find.byKey(KWidgetkeys.widget.nawbar.iconMic),
      //   hasMic ? findsOneWidget : findsNothing,
      // );

      expect(
        find.byKey(KWidgetkeys.widget.nawbar.button),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.nawbar.iconPerson),
        findsNothing,
      );

      await tester.enterText(
        find.byKey(KWidgetkeys.widget.nawbar.field),
        searchText,
      );

      await tester.pumpAndSettle();

      expect(
        find.descendant(
          of: find.byKey(KWidgetkeys.widget.nawbar.field),
          matching: find.text(searchText),
        ),
        findsOneWidget,
      );
    },
  );

  final textField = tester.widget<TextField>(
    find.byKey(
      KWidgetkeys.widget.nawbar.field,
    ),
  );
  textField.focusNode?.unfocus();

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.nawbar.logo), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.nawbar.field), findsOneWidget);

  // expect(
  //   find.byKey(KWidgetkeys.widget.nawbar.iconMic),
  //   hasMic ? findsOneWidget : findsNothing,
  // );

  expect(
    find.byKey(KWidgetkeys.widget.nawbar.button),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.nawbar.iconPerson),
    findsOneWidget,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.nawbar.field),
    searchText,
  );

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.nawbar.logo), findsNothing);

  expect(
    find.byKey(KWidgetkeys.widget.nawbar.iconPerson),
    findsNothing,
  );
}
