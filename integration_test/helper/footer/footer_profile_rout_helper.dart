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
    itemKey: KWidgetkeys.widget.footer.profileButton,
  );

  expect(
    find.byKey(KWidgetkeys.widget.footer.profileButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.footer.profileButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.profile.screen),
    findsOneWidget,
  );
}
