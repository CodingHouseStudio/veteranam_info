import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> popupMenuButtonHelper({
  required WidgetTester tester,
  required List<Key> buttonListKeys,
  required Key buttonKey,
}) async {
  expect(
    find.byKey(buttonKey),
    findsWidgets,
  );

  for (final key in buttonListKeys) {
    expect(
      find.byKey(key),
      findsNothing,
    );
  }

  await tester.tap(
    find.byKey(buttonKey).first,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  for (final key in buttonListKeys) {
    expect(
      find.byKey(key),
      findsOneWidget,
    );
  }

  await tester.tap(
    find.byKey(buttonKey).first,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  for (final key in buttonListKeys) {
    expect(
      find.byKey(key),
      findsNothing,
    );
  }
}
