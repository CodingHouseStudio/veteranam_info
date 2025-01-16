import 'dart:ui' show PointerDeviceKind;

import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> additionalButtonHelper(
  WidgetTester tester,
) async {
  final isDesk = find.byKey(ButtonAdditionalKeys.desk).evaluate().isNotEmpty;

  expect(
    find.byKey(ButtonAdditionalKeys.desk),
    isDesk ? findsOneWidget : findsNothing,
  );

  expect(
    find.byKey(ButtonAdditionalKeys.mob),
    isDesk ? findsNothing : findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: isDesk ? ButtonAdditionalKeys.desk : ButtonAdditionalKeys.mob,
  );
  expect(
    find.byKey(ButtonAdditionalKeys.icon),
    findsOneWidget,
  );
  expect(
    find.byKey(ButtonAdditionalKeys.text),
    findsOneWidget,
  );

  if (isDesk) {
    final widgetLocation = tester.getCenter(
      find.byKey(ButtonAdditionalKeys.text).first,
    );

    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);

    await gesture.addPointer(location: widgetLocation);

    await tester.pumpAndSettle();

    await gesture.removePointer(location: widgetLocation);

    await tester.pumpAndSettle();
  }
}
