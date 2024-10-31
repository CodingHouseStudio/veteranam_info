import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> donatesCardHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.investors.cards),
    findsWidgets,
  );

  expect(find.byKey(KWidgetkeys.screen.investors.card), findsWidgets);

  await donateCardHelper(tester: tester, isDesk: true);

  final widgetLocation =
      tester.getCenter(find.byKey(KWidgetkeys.widget.donateCard.widget).first);

  final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);

  await gesture.addPointer(location: widgetLocation);

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.donateCard.subtitle),
    findsOneWidget,
  );
}
