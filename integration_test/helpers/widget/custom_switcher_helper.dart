import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> customSwitcherHelper({
  required WidgetTester tester,
  bool first = true,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.customSwitcher.widget),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.customSwitcher.item),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.customSwitcher.text),
    findsWidgets,
  );

  await tester.tap(
    _getFinder(
      first: first,
      finder: find.byKey(KWidgetkeys.widget.customSwitcher.widget),
    ),
  );
  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.customSwitcher.item),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.customSwitcher.text),
    findsWidgets,
  );

  /*final textWidget = tester.widget<Text>(
    find.byKey(KWidgetkeys.widget.customSwitcher.text),
  );*/

  await tester.tap(
    _getFinder(
      first: first,
      finder: find.byKey(KWidgetkeys.widget.customSwitcher.item),
    ),
    warnIfMissed: false,
  );
  await tester.pumpAndSettle();

  /* expect(
    tester
        .widget<Text>(
          find.byKey(KWidgetkeys.widget.customSwitcher.text),
        )
        .data,
    isNot(textWidget.data),
  );*/

  await tester.tap(
    _getFinder(
      first: first,
      finder: find.byKey(KWidgetkeys.widget.customSwitcher.widget),
    ),
  );
  await tester.pumpAndSettle();

  await tester.tap(
    _getFinder(
      first: first,
      finder: find.byKey(KWidgetkeys.widget.customSwitcher.item),
    ),
    warnIfMissed: false,
  );
  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.customSwitcher.item),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.customSwitcher.text),
    findsWidgets,
  );

  await tester.tap(
    _getFinder(
      first: first,
      finder: find.byKey(KWidgetkeys.widget.customSwitcher.item),
    ),
    warnIfMissed: false,
  );
  await tester.pumpAndSettle();

  /* expect(
    tester
        .widget<Text>(
          find.byKey(KWidgetkeys.widget.customSwitcher.text),
        )
        .data,
    textWidget.data,
  );*/
}

Finder _getFinder({required bool first, required Finder finder}) =>
    first ? finder.first : finder.last;
