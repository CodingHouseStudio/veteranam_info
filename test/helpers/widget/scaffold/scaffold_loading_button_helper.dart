import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> scaffoldLoadingButtonHelper({
  required WidgetTester tester,
  bool hoverOnButton = false,
}) async {
  expect(find.byKey(ScaffoldKeys.loadingButton), findsOneWidget);

  if (hoverOnButton) {
    await loadingButtonHelper(tester);
  }

  await scrollingHelper(
    tester: tester,
    itemKey: ScaffoldKeys.loadingButton,
  );

  await tester.tap(find.byKey(ScaffoldKeys.loadingButton));

  await tester.pumpAndSettle();
}
