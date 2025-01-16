import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> dialogFailureGetTapHelper({
  required WidgetTester tester,
  bool isFailure = true,
}) async {
  expect(find.byKey(DialogsKeys.failureButton), findsOneWidget);

  await scrollingHelperInt(
    tester: tester,
    itemKey: DialogsKeys.failureButton,
  );

  await tester.tap(find.byKey(DialogsKeys.failureButton));

  await tester.pumpAndSettle();
}
