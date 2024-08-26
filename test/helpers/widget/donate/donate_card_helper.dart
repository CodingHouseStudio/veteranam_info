import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> donateCardHelper({
  required WidgetTester tester,
  required bool isDesk,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.donateCard.widget,
  );

  expect(find.byKey(KWidgetkeys.widget.donateCard.widget), findsWidgets);

  await tester.pumpAndSettle();

  // expect(find.byKey(KWidgetkeys.widget.donateCard.image), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.donateCard.title), findsWidgets);

  expect(
    find.byKey(KWidgetkeys.widget.donateCard.subtitle),
    isDesk ? findsNothing : findsWidgets,
  );

  expect(find.byKey(KWidgetkeys.widget.donateCard.button), findsWidgets);

  await donateButtonHelper(tester: tester, tap: false, isDesk: isDesk);
}
