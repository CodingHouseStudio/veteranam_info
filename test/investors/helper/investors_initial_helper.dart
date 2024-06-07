import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';
import 'helper.dart';

Future<void> investorsInitialHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.screen.investors.fundTitle), findsOneWidget);

  expect(find.byKey(KWidgetkeys.screen.investors.fundSubtitle), findsOneWidget);

  expect(find.byKey(KWidgetkeys.screen.investors.buttonMock), findsNothing);

  expect(find.byKey(KWidgetkeys.screen.investors.donateCard), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.donateCard.title,
  );

  await donateCardHelper(tester: tester, isDesk: false);

  await donatesCardHelper(tester);
}
