import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> listLoadFilterHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.newsCard.title), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.information.button,
    // offset: KTestConstants.scrollingUp500,
  );

  expect(find.byKey(KWidgetkeys.screen.information.button), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.screen.information.button));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.newsCard.title,
    offset: KTestConstants.scrollingUp,
  );

  final widgets = find.byKey(KWidgetkeys.widget.newsCard.title);

  expect(widgets, findsWidgets);

  expect(widgets.evaluate().length, greaterThan(1));

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );

  await filterChipHelper(tester);

  // expect(find.byKey(KWidgetkeys.widget.newsCard.title), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.information.button,
    // offset: KTestConstants.scrollingUp500,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.information.button));

  await tester.pumpAndSettle();

  final widgetsTwoTap = find.byKey(KWidgetkeys.widget.newsCard.title);

  expect(widgets.evaluate().length, widgetsTwoTap.evaluate().length);
}
