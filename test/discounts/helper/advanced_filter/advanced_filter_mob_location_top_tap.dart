import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> advancedFilterMobLocationTopTapHelper(
  WidgetTester tester, {
  bool reset = true,
}) async {
  await _openHelper(tester);

  await confirmDialogCancelIconHelper(
    tester,
  );

  await _openHelper(tester);

  await confirmDialogUnconfirmHelper(
    tester,
  );

  await _openHelper(tester);

  await confirmDialogHelper(tester);

  expect(
    find.byKey(DiscountsFilterKeys.mobButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.mobButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsFilterKeys.cancelChip),
    findsOneWidget,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.resetButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsFilterKeys.list),
    findsNothing,
  );
}

Future<void> _openHelper(WidgetTester tester) async {
  expect(
    find.byKey(DiscountsFilterKeys.mobButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.mobButton));

  await tester.pumpAndSettle();

  await chekPointSignleTapHelper(tester: tester, hasAmount: true);

  await tester.tapAt(Offset.zero);

  await tester.pumpAndSettle();
}
