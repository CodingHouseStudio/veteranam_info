import 'package:flutter/foundation.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';

Future<void> popupMenyButtonTapHelper({
  required WidgetTester tester,
  required List<Key> buttonListKeys,
  required Key buttonKey,
  bool canTapOnItemAgain = false,
  bool firstTapIsEnabled = false,
}) async {
  final buttonFinder = find.byKey(buttonKey).first;
  await popupMenuButtonHelper(
    tester: tester,
    buttonListKeys: buttonListKeys,
    buttonKey: buttonKey,
  );

  await tester.tap(
    buttonFinder,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  for (var i = 0; i < buttonListKeys.length; i++) {
    final key = buttonListKeys.elementAt(i);

    expect(
      find.byKey(key),
      findsOneWidget,
    );

    await tester.tap(find.byKey(key));

    await tester.pumpAndSettle();

    if (i != 0 || firstTapIsEnabled) {
      expect(
        find.byKey(key),
        findsNothing,
      );

      await tester.tap(
        buttonFinder,
        warnIfMissed: false,
      );

      await tester.pumpAndSettle();

      if (!canTapOnItemAgain) {
        await tester.tap(find.byKey(key));

        await tester.pumpAndSettle();

        expect(
          find.byKey(key),
          findsOneWidget,
        );
      }
    }
  }

  final firstButtonKey = buttonListKeys.first;

  expect(find.byKey(firstButtonKey), findsOneWidget);

  await tester.tap(find.byKey(firstButtonKey));

  await tester.pumpAndSettle();

  expect(find.byKey(firstButtonKey), findsNothing);
}
