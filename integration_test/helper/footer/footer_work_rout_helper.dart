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
    itemKey: KWidgetkeys.widget.footer.workButton,
  );

  expect(
    find.byKey(KWidgetkeys.widget.footer.workButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.footer.workButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.work.screen),
    findsOneWidget,
  );
}
