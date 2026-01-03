import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> deleteAccountDialoglHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(CompanyKeys.deleteButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: CompanyKeys.deleteButton,
    offset: KTestConstants.scrollingDown,
  );

  await tester.tap(find.byKey(CompanyKeys.deleteButton));

  await tester.pumpAndSettle();
}
