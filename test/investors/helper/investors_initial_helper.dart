import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';
import 'helper.dart';

Future<void> investorsInitialHelper(
  WidgetTester tester,
) async {
  await feedbackHelper(tester);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.feedback.buttonClear,
  );

  expect(find.byKey(KWidgetkeys.screen.investors.fundTitle), findsOneWidget);

  expect(find.byKey(KWidgetkeys.screen.investors.fundSubtitle), findsOneWidget);

  expect(find.byKey(KWidgetkeys.screen.investors.buttonMock), findsNothing);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.investors.fundSubtitle,
  );

  expect(find.byKey(KWidgetkeys.screen.investors.donateCard), findsOneWidget);

  await donateCardHelper(tester: tester, isDesk: false);

  await donatesCardHelper(tester);
}
