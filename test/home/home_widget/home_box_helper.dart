import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> homeBoxHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.home.box),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.home.boxIcon),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.home.boxSubtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.home.boxTitle),
    findsOneWidget,
  );

  await boxHelper(tester);
}
