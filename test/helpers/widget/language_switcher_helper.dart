import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> languageSwitcherHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(LanguageSwitcherKeys.widget),
    findsOneWidget,
  );

  // expect(
  //   find.byKey(LanguageSwitcherKeys.item),
  //   findsWidgets,
  // );

  expect(
    find.byKey(LanguageSwitcherKeys.text),
    findsWidgets,
  );

  await tester.tap(
    find.byKey(LanguageSwitcherKeys.widget),
  );
  await tester.pumpAndSettle();

  // expect(
  //   find.byKey(LanguageSwitcherKeys.item),
  //   findsWidgets,
  // );

  expect(
    find.byKey(LanguageSwitcherKeys.text),
    findsWidgets,
  );

  /*final textWidget = tester.widget<Text>(
    find.byKey(LanguageSwitcherKeys.text),
  );*/

  await tester.tap(
    find.byKey(LanguageSwitcherKeys.widget),
    warnIfMissed: false,
  );
  await tester.pumpAndSettle();

  /* expect(
    tester
        .widget<Text>(
          find.byKey(LanguageSwitcherKeys.text),
        )
        .data,
    isNot(textWidget.data),
  );*/

  await tester.tap(
    find.byKey(LanguageSwitcherKeys.widget),
  );
  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(LanguageSwitcherKeys.widget),
    warnIfMissed: false,
  );
  await tester.pumpAndSettle();

  expect(
    find.byKey(LanguageSwitcherKeys.widget),
    findsWidgets,
  );

  expect(
    find.byKey(LanguageSwitcherKeys.text),
    findsWidgets,
  );

  await tester.tap(
    find.byKey(LanguageSwitcherKeys.widget),
    warnIfMissed: false,
  );
  await tester.pumpAndSettle();

  /* expect(
    tester
        .widget<Text>(
          find.byKey(LanguageSwitcherKeys.text),
        )
        .data,
    textWidget.data,
  );*/
}
