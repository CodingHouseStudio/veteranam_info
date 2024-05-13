import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> donateCardHelper({
  required WidgetTester tester,
  required bool isDesk,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.donateCard.widget,
  );

  expect(find.byKey(KWidgetkeys.widget.donateCard.widget), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.donateCard.button), findsWidgets);

  // expect(find.byKey(KWidgetkeys.widget.donateCard.image), findsWidgets);

  expect(
    find.byKey(KWidgetkeys.widget.donateCard.subtitle),
    isDesk ? findsNothing : findsWidgets,
  );

  expect(find.byKey(KWidgetkeys.widget.donateCard.title), findsWidgets);
}
