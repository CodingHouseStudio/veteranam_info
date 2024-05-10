import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> donatesCardHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(tester: tester);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.investors.donateCards,
    offset: KTestConstants.scrollingDown,
  );

  expect(find.byKey(KWidgetkeys.screen.investors.donateCards), findsWidgets);

  await donateCardHelper(tester);

  final widgetLocation =
      tester.getCenter(find.byKey(KWidgetkeys.widget.donateCard.widget).first);

  final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);

  await gesture.addPointer(location: widgetLocation);

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.donateCard.subtitle), findsOneWidget);

  await changeWindowSizeHelper(tester: tester, setDefaultSize: true);
}
