import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> footerWorkRoutHelper(
  WidgetTester tester,
) async {
  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrolling,
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
