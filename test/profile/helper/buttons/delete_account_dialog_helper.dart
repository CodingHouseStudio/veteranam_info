import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../helper.dart';

Future<void> deleteAccountDialoglHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(ProfileKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();

  await profileDeleteButtonHelper(tester);
}
