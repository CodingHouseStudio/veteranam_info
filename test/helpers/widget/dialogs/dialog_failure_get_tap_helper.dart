import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> dialogFailureGetTapHelper({
  required WidgetTester tester,
  bool isFailure = true,
}) async {
  expect(find.byKey(KWidgetkeys.widget.dialogs.failureButton), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.dialogs.failureButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.dialogs.failureButton));

  await tester.pumpAndSettle();
}
