import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../helper.dart';

Future<void> footerWorkRoutHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    item: find.byKey(KWidgetkeys.footerKeys.workButton),
  );

  expect(find.byKey(KWidgetkeys.footerKeys.workButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.footerKeys.workButton));

  await tester.pumpAndSettle();
}
