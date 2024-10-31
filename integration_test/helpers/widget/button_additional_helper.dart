import 'dart:ui' show PointerDeviceKind;

import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> additionalButtonHelper(
  WidgetTester tester,
) async {
  final isDesk = find
      .byKey(KWidgetkeys.widget.buttonAdditional.desk)
      .evaluate()
      .isNotEmpty;

  expect(
    find.byKey(KWidgetkeys.widget.buttonAdditional.desk),
    isDesk ? findsOneWidget : findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.buttonAdditional.mob),
    isDesk ? findsNothing : findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: isDesk
        ? KWidgetkeys.widget.buttonAdditional.desk
        : KWidgetkeys.widget.buttonAdditional.mob,
  );
  expect(
    find.byKey(KWidgetkeys.widget.buttonAdditional.icon),
    findsOneWidget,
  );
  expect(
    find.byKey(KWidgetkeys.widget.buttonAdditional.text),
    findsOneWidget,
  );

  if (isDesk) {
    final widgetLocation = tester.getCenter(
      find.byKey(KWidgetkeys.widget.buttonAdditional.text).first,
    );

    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);

    await gesture.addPointer(location: widgetLocation);

    await tester.pumpAndSettle();

    await gesture.removePointer(location: widgetLocation);

    await tester.pumpAndSettle();
  }
}
