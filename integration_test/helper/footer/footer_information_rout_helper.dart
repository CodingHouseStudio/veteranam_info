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
    item: find.byKey(KWidgetkeys.footerKeys.informationButton),
  );

  expect(find.byKey(KWidgetkeys.footerKeys.informationButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.footerKeys.informationButton));

  await tester.pumpAndSettle();
}
