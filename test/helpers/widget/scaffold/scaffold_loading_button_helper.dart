import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> scaffoldLoadingButtonHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.scaffold.loadingButton), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.scaffold.loadingButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.scaffold.loadingButton));

  await tester.pumpAndSettle();
}
