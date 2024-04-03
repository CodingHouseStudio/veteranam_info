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
    itemKey: KWidgetkeys.widget.footer.informationButton,
  );

  expect(
    find.byKey(KWidgetkeys.widget.footer.informationButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.footer.informationButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.information.screen),
    findsOneWidget,
  );
}
