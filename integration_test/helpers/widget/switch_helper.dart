import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> switchHelper({
  required WidgetTester tester,
  bool enabled = true,
  bool isActive = false,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.switchKeys.widget),
    findsOneWidget,
  );

  // expect(
  //   find.byKey(KWidgetkeys.widget.switchKeys.icon),
  //   findsOneWidget,
  // );

  // expect(
  //   find.byKey(KWidgetkeys.widget.switchKeys.item),
  //   findsWidgets,
  // );

  expect(
    find.byKey(KWidgetkeys.widget.switchKeys.active),
    isActive ? findsOneWidget : findsNothing,
  );

  // late var switchWidget =
  //     tester.widget<Switch>(find.byKey(KWidgetkeys.widget.switchKeys.widget)
  // );

  // expect(switchWidget.value, isFalse);
  if (enabled) {
    await scrollingHelperInt(
      tester: tester,
      itemKey: KWidgetkeys.widget.switchKeys.widget,
    );

    await tester.tap(find.byKey(KWidgetkeys.widget.switchKeys.widget));

    await tester.pumpAndSettle();

    expect(
      find.byKey(KWidgetkeys.widget.switchKeys.active),
      findsOneWidget,
    );

    await tester.tap(find.byKey(KWidgetkeys.widget.switchKeys.widget));

    await tester.pumpAndSettle();

    expect(
      find.byKey(KWidgetkeys.widget.switchKeys.active),
      findsNothing,
    );
  }

  // switchWidget =
  //     tester.widget<Switch>(find.byKey(KWidgetkeys.widget.switchKeys.widget
  // ));

  // expect(switchWidget.value, isTrue);

  // await scrollingHelper(
  //   tester: tester,
  //   itemKey: KWidgetkeys.widget.switchKeys.widget,
  // );

  // await tester.tap(find.byKey(KWidgetkeys.widget.switchKeys.widget));

  // await tester.pumpAndSettle();

  // switchWidget =
  //     tester.widget<Switch>(find.byKey(KWidgetkeys.widget.switchKeys.widget
  // ));

  // expect(switchWidget.value, isFalse);
}
