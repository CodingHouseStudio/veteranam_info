import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> donatesCardHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.investors.cards),
    findsWidgets,
  );

  expect(find.byKey(KWidgetkeys.screen.investors.card), findsWidgets);

  await donateCardHelper(tester: tester, isDesk: true);

  await hoverHelper(
    tester: tester,
    key: KWidgetkeys.widget.donateCard.widget,
    hoverElement: KWidgetkeys.widget.donateCard.subtitle,
  );
}
