import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> nawbarHelper({
  required WidgetTester tester,
  required String searchText,
}) async {
  await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

  expect(find.byKey(NawbarKeys.widget), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    itemKey: NawbarKeys.widget,
  );
  late FinderResult<Element> language;

  // if (Config.isDevelopment) {
  //   expect(find.byKey(NawbarKeys.field), findsOneWidget);

  //   final textField = tester.widget<TextField>(
  //     find.byKey(
  //       NawbarKeys.field,
  //     ),
  //   );

  //   textField.focusNode!.unfocus();

  //   await tester.pumpAndSettle();

  //   language = find.byKey(NawbarKeys.language).evaluate();

  //   if (language.isNotEmpty) {
  //     expect(find.byKey(NawbarKeys.language), findsOneWidget);

  //     await languageSwitcherHelper(tester);
  //   }
  // } else {
  language = find.byKey(NawbarKeys.language).evaluate();

  if (language.isNotEmpty) {
    await buttonBottomLineHelper(
      tester: tester,
      isDesk: true,
    );

    expect(find.byKey(NawbarKeys.language), findsOneWidget);

    await languageSwitcherHelper(tester);

    expect(
      find.byKey(NawbarKeys.discountsButton),
      findsOneWidget,
    );

    expect(
      find.byKey(NawbarKeys.investorsButton),
      findsOneWidget,
    );

    expect(
      find.byKey(NawbarKeys.feedbackButton),
      findsOneWidget,
    );
  }
  // }
  expect(find.byKey(NawbarKeys.logo), findsOneWidget);

  if (language.isEmpty ||
      find.byKey(NawbarKeys.loginButton).evaluate().isEmpty) {
    expect(
      find.byKey(NawbarKeys.loginButton),
      findsNothing,
    );

    expect(
      find.byKey(NawbarKeys.userIcon),
      findsOneWidget,
    );
  } else {
    expect(
      find.byKey(NawbarKeys.loginButton),
      findsOneWidget,
    );

    expect(
      find.byKey(NawbarKeys.userIcon),
      findsNothing,
    );
  }

  // expect(
  //   find.byKey(NawbarKeys.iconMic),
  //   hasMic ? findsOneWidget : findsNothing,
  // );
  // if (Config.isDevelopment) {
  //   await tester.enterText(
  //     find.byKey(NawbarKeys.field),
  //     searchText,
  //   );

  //   await tester.pumpAndSettle();

  //   expect(
  //     find.descendant(
  //       of: find.byKey(NawbarKeys.field),
  //       matching: find.text(searchText),
  //     ),
  //     findsOneWidget,
  //   );

  //   // expect(
  //   //   find.byKey(NawbarKeys.iconMic),
  //   //   hasMic ? findsOneWidget : findsNothing,
  //   // );
  //   if (language.isEmpty) {
  //     expect(find.byKey(NawbarKeys.logo), findsNothing);

  //     expect(find.byKey(NawbarKeys.field), findsOneWidget);

  //     expect(find.byKey(NawbarKeys.loginIcon), findsNothing);

  //     final textField = tester.widget<TextField>(
  //       find.byKey(
  //         NawbarKeys.field,
  //       ),
  //     );

  //     textField.focusNode!.unfocus();

  //     await tester.pumpAndSettle();
  //   }

  //   expect(find.byKey(NawbarKeys.logo), findsOneWidget);

  //   expect(find.byKey(NawbarKeys.field), findsOneWidget);
  // }
}
