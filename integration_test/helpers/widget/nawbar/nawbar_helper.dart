import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> nawbarHelper({
  required WidgetTester tester,
  required String searchText,
}) async {
  expect(find.byKey(KWidgetkeys.widget.nawbar.widget), findsOneWidget);

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.widget.nawbar.widget,
  );
  late Iterable<Widget> language;

  if (Config.isDevelopment) {
    expect(find.byKey(KWidgetkeys.widget.nawbar.field), findsOneWidget);

    final textField = tester.widget<TextField>(
      find.byKey(
        KWidgetkeys.widget.nawbar.field,
      ),
    );

    textField.focusNode!.unfocus();

    await tester.pumpAndSettle();

    language =
        tester.widgetList(find.byKey(KWidgetkeys.widget.nawbar.language));

    if (language.isNotEmpty) {
      expect(find.byKey(KWidgetkeys.widget.nawbar.language), findsOneWidget);

      await languageSwitcherHelper(tester);
    }
  } else {
    language =
        tester.widgetList(find.byKey(KWidgetkeys.widget.nawbar.language));

    if (language.isNotEmpty) {
      expect(find.byKey(KWidgetkeys.widget.nawbar.language), findsOneWidget);

      await languageSwitcherHelper(tester);
    }

    if (language.isNotEmpty) {
      expect(
        find.byKey(KWidgetkeys.widget.nawbar.discountsButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.nawbar.investorsButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.nawbar.feedbackButton),
        findsOneWidget,
      );
    }
  }

  expect(find.byKey(KWidgetkeys.widget.nawbar.logo), findsOneWidget);

  // expect(
  //   find.byKey(KWidgetkeys.widget.nawbar.iconMic),
  //   hasMic ? findsOneWidget : findsNothing,
  // );
  if (Config.isDevelopment) {
    if (language.isEmpty) {
      expect(
        find.byKey(KWidgetkeys.widget.nawbar.loginButton),
        findsNothing,
      );

      expect(
        find.byKey(KWidgetkeys.widget.nawbar.loginIcon),
        findsOneWidget,
      );
    } else {
      expect(
        find.byKey(KWidgetkeys.widget.nawbar.loginButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.nawbar.loginIcon),
        findsNothing,
      );
    }

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

    // expect(
    //   find.byKey(KWidgetkeys.widget.nawbar.iconMic),
    //   hasMic ? findsOneWidget : findsNothing,
    // );
    if (language.isEmpty) {
      expect(find.byKey(KWidgetkeys.widget.nawbar.logo), findsNothing);

      expect(find.byKey(KWidgetkeys.widget.nawbar.field), findsOneWidget);

      expect(find.byKey(KWidgetkeys.widget.nawbar.loginIcon), findsNothing);

      final textField = tester.widget<TextField>(
        find.byKey(
          KWidgetkeys.widget.nawbar.field,
        ),
      );

      textField.focusNode!.unfocus();

      await tester.pumpAndSettle();
    }

    expect(find.byKey(KWidgetkeys.widget.nawbar.logo), findsOneWidget);

    expect(find.byKey(KWidgetkeys.widget.nawbar.field), findsOneWidget);
  }
}