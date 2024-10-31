import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> donateCardHelper({
  required WidgetTester tester,
  required bool isDesk,
}) async {
  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.widget.donateCard.widget,
  );

  expect(find.byKey(KWidgetkeys.widget.donateCard.widget), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.donateCard.button), findsWidgets);

  // expect(find.byKey(KWidgetkeys.widget.donateCard.image), findsWidgets);

  expect(
    find.byKey(KWidgetkeys.widget.donateCard.subtitle),
    isDesk ? findsNothing : findsWidgets,
  );

  expect(find.byKey(KWidgetkeys.widget.donateCard.title), findsWidgets);
}
