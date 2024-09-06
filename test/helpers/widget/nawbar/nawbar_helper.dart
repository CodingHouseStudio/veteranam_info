import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> nawbarHelper({
  required WidgetTester tester,
  required String searchText,
}) async {
  await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

  expect(find.byKey(KWidgetkeys.widget.nawbar.widget), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.nawbar.widget,
  );
  late FinderResult<Element> language;

  if (Config.isDevelopment) {
    expect(find.byKey(KWidgetkeys.widget.nawbar.field), findsOneWidget);

    final textField = tester.widget<TextField>(
      find.byKey(
        KWidgetkeys.widget.nawbar.field,
      ),
    );

    textField.focusNode!.unfocus();

    await tester.pumpAndSettle();

    language = find.byKey(KWidgetkeys.widget.nawbar.language).evaluate();

    if (language.isNotEmpty) {
      expect(find.byKey(KWidgetkeys.widget.nawbar.language), findsOneWidget);

      await languageSwitcherHelper(tester);
    }
  } else {
    language = find.byKey(KWidgetkeys.widget.nawbar.language).evaluate();

    if (language.isNotEmpty) {
      await buttonBottomLineHelper(
        tester: tester,
        isDesk: true,
      );

      expect(find.byKey(KWidgetkeys.widget.nawbar.language), findsOneWidget);

      await languageSwitcherHelper(tester);

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
  final isTablet =
      find.byKey(KWidgetkeys.widget.nawbar.loginButton).evaluate().isEmpty &&
          language.isNotEmpty;
  expect(find.byKey(KWidgetkeys.widget.nawbar.logo), findsOneWidget);

  // expect(
  //   find.byKey(KWidgetkeys.widget.nawbar.iconMic),
  //   hasMic ? findsOneWidget : findsNothing,
  // );
  if (Config.isDevelopment) {
    if (language.isEmpty || isTablet) {
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
