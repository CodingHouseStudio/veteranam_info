import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';
import 'helper.dart';

Future<void> informationInitialHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp200,
  );

  expect(
    find.byKey(KWidgetkeys.screen.information.button),
    findsOneWidget,
  );

  await changeWindowSizeHelper(tester: tester);

  expect(
    find.byKey(KWidgetkeys.screen.information.buttonIcon),
    findsOneWidget,
  );

  await changeWindowSizeHelper(tester: tester, setDefaultSize: true);

  expect(
    find.byKey(KWidgetkeys.screen.information.buttonIcon),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.screen.information.buttonMock),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.screen.information.card),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );

  expect(
    find.byKey(KWidgetkeys.screen.information.subtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.information.title),
    findsOneWidget,
  );

  await informationFilterHelper(tester);

  await newsCardHelper(tester: tester);
}
