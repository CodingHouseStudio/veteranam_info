import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> switchOfflineHelper({
  required WidgetTester tester,
  bool enabled = true,
  bool isActive = false,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.switchOffline.widget),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.switchOffline.icon),
    isActive ? findsNothing : findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.switchOffline.active),
    isActive ? findsOneWidget : findsNothing,
  );

  if (enabled) {
    await scrollingHelper(
      tester: tester,
      itemKey: KWidgetkeys.widget.switchOffline.widget,
    );

    await tester.tap(find.byKey(KWidgetkeys.widget.switchOffline.widget));

    await tester.pumpAndSettle();

    expect(
      find.byKey(KWidgetkeys.widget.switchOffline.active),
      isActive ? findsNothing : findsOneWidget,
    );

    await tester.tap(find.byKey(KWidgetkeys.widget.switchOffline.widget));

    await tester.pumpAndSettle();

    expect(
      find.byKey(KWidgetkeys.widget.switchOffline.active),
      isActive ? findsOneWidget : findsNothing,
    );
  }
}
