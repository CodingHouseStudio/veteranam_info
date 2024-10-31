import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> nawbarMenuHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.nawbar.menuButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.widget.nawbar.menuButton));

  await tester.pumpAndSettle();

  await menuDialogHelper(
    tester,
  );
}
