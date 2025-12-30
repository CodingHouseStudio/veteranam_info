import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> switchOfflineHelper({
  required WidgetTester tester,
  bool enabled = true,
  bool isActive = false,
}) async {
  expect(
    find.byKey(SwitchOfflineKeys.widget),
    findsOneWidget,
  );

  expect(
    find.byKey(SwitchOfflineKeys.icon),
    isActive ? findsNothing : findsOneWidget,
  );

  expect(
    find.byKey(SwitchOfflineKeys.active),
    isActive ? findsOneWidget : findsNothing,
  );

  if (enabled) {
    await scrollingHelper(
      tester: tester,
      itemKey: SwitchOfflineKeys.widget,
    );

    await tester.tap(find.byKey(SwitchOfflineKeys.widget));

    await tester.pumpAndSettle();

    expect(
      find.byKey(SwitchOfflineKeys.active),
      isActive ? findsNothing : findsOneWidget,
    );

    await tester.tap(find.byKey(SwitchOfflineKeys.widget));

    await tester.pumpAndSettle();

    expect(
      find.byKey(SwitchOfflineKeys.active),
      isActive ? findsOneWidget : findsNothing,
    );
  }
}
