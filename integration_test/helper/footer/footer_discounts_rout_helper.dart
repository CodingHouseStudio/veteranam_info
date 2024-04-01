import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../helper.dart';

Future<void> footerDiscountsRoutHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
  );
  await scrollingHelper(
    tester: tester,
    item: KWidgetkeys.footerKeys.discountsButton,
  );

  expect(find.byKey(KWidgetkeys.footerKeys.discountsButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.footerKeys.discountsButton));

  await tester.pumpAndSettle();
}
