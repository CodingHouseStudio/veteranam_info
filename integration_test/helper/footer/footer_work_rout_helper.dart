import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../helper.dart';

Future<void> footerWorkRoutHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
  );
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widgetKeys.footerKeys.workButton,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.footerKeys.workButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widgetKeys.footerKeys.workButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screenKeys.workScreenKeys.screen),
    findsOneWidget,
  );
}
