import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> scaffoldLoadingButtonHelper({
  required WidgetTester tester,
  bool hoverOnButton = false,
}) async {
  expect(find.byKey(KWidgetkeys.widget.scaffold.loadingButton), findsOneWidget);

  if (hoverOnButton) {
    await loadingButtonHelper(tester);
  }

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.scaffold.loadingButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.scaffold.loadingButton));

  await tester.pumpAndSettle();
}
