import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> languageSwitcherHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.widget),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.item),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.text),
    findsWidgets,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.languageSwitcher.widget),
  );
  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.item),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.text),
    findsWidgets,
  );

  /*final textWidget = tester.widget<Text>(
    find.byKey(KWidgetkeys.widget.languageSwitcher.text),
  );*/

  await tester.tap(
    find.byKey(KWidgetkeys.widget.languageSwitcher.item).last,
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
    find.byKey(KWidgetkeys.widget.languageSwitcher.item).last,
    warnIfMissed: false,
  );
  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.item),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.text),
    findsWidgets,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.languageSwitcher.item).first,
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
