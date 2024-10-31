import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> languageSwitcherHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.widget),
    findsOneWidget,
  );

  // expect(
  //   find.byKey(KWidgetkeys.widget.languageSwitcher.item),
  //   findsWidgets,
  // );

  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.text),
    findsWidgets,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.languageSwitcher.widget),
  );
  await tester.pumpAndSettle();

  // expect(
  //   find.byKey(KWidgetkeys.widget.languageSwitcher.item),
  //   findsWidgets,
  // );

  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.text),
    findsWidgets,
  );

  /*final textWidget = tester.widget<Text>(
    find.byKey(KWidgetkeys.widget.languageSwitcher.text),
  );*/

  await tester.tap(
    find.byKey(KWidgetkeys.widget.languageSwitcher.widget),
    warnIfMissed: false,
  );
  await tester.pumpAndSettle();

  /* expect(
    tester
        .widget<Text>(
          find.byKey(KWidgetkeys.widget.languageSwitcher.text),
        )
        .data,
    isNot(textWidget.data),
  );*/

  await tester.tap(
    find.byKey(KWidgetkeys.widget.languageSwitcher.widget),
  );
  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(KWidgetkeys.widget.languageSwitcher.widget),
    warnIfMissed: false,
  );
  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.widget),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.text),
    findsWidgets,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.languageSwitcher.widget),
    warnIfMissed: false,
  );
  await tester.pumpAndSettle();

  /* expect(
    tester
        .widget<Text>(
          find.byKey(KWidgetkeys.widget.languageSwitcher.text),
        )
        .data,
    textWidget.data,
  );*/
}
