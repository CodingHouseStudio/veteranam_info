import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> thanksInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.thanks.title),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.thanks.subtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.thanks.myProfielBox),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.thanks.homeBox),
    findsOneWidget,
  );

  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.thanks.myProfielBox),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.thanks.homeBox),
        findsOneWidget,
      );
    },
  );
}
