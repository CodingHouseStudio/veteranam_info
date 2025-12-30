import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> multiDropFieldRemoveHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(MultiDropFieldKeys.chips), findsWidgets);

  await tester.tap(find.byKey(MultiDropFieldKeys.chips).first);

  await tester.pumpAndSettle();
}
