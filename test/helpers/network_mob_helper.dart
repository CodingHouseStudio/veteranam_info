import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';

Future<void> networkMobHelper({
  required WidgetTester tester,
  required Future<void> Function() pumpApp,
}) async {
  await networkHelper(
    pumpApp: pumpApp,
    tester: tester,
  );

  expect(
    find.byKey(KWidgetkeys.widget.networkBanner.widget),
    findsNothing,
  );
  expect(
    find.byKey(KWidgetkeys.widget.networkBanner.iconNoInternet),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    scrollKey: KWidgetkeys.widget.nawbar.widget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.networkBanner.iconNoInternet),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp150,
  );

  expect(
    find.byKey(KWidgetkeys.widget.networkBanner.widget),
    findsNothing,
  );
  expect(
    find.byKey(KWidgetkeys.widget.networkBanner.iconNoInternet),
    findsNothing,
  );
}
