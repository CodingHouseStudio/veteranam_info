import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> donateCardHelper({
  required WidgetTester tester,
  required bool isDesk,
}) async {
  await scrollingHelperInt(
    tester: tester,
    itemKey: DonateCardKeys.widget,
  );

  expect(find.byKey(DonateCardKeys.widget), findsWidgets);

  expect(find.byKey(DonateCardKeys.button), findsWidgets);

  // expect(find.byKey(DonateCardKeys.image), findsWidgets);

  expect(
    find.byKey(DonateCardKeys.subtitle),
    isDesk ? findsNothing : findsWidgets,
  );

  expect(find.byKey(DonateCardKeys.title), findsWidgets);
}
