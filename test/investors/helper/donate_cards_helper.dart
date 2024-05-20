import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> donatesCardHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(tester: tester);

  expect(find.byKey(KWidgetkeys.screen.investors.donateCards), findsWidgets);

  expect(find.byKey(KWidgetkeys.screen.investors.donateCard), findsWidgets);

  await donateCardHelper(tester: tester, isDesk: true);

  final widgetLocation =
      tester.getCenter(find.byKey(KWidgetkeys.widget.donateCard.widget).first);

  final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);

  await gesture.addPointer(location: widgetLocation);

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.donateCard.subtitle), findsOneWidget);

  await changeWindowSizeHelper(tester: tester, setDefaultSize: true);
}
