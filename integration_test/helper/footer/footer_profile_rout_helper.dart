import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../helper.dart';

Future<void> footerProfileRoutHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
  );
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widgetKeys.footerKeys.profileButton,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.footerKeys.profileButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widgetKeys.footerKeys.profileButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screenKeys.profileScreenKeys.screen),
    findsOneWidget,
  );
}
