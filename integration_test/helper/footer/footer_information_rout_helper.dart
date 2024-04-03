import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../helper.dart';

Future<void> footerInformationRoutHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
  );
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widgetKeys.footerKeys.informationButton,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.footerKeys.informationButton),
    findsOneWidget,
  );

  await tester
      .tap(find.byKey(KWidgetkeys.widgetKeys.footerKeys.informationButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screenKeys.informationScreenKeys.screen),
    findsOneWidget,
  );
}
