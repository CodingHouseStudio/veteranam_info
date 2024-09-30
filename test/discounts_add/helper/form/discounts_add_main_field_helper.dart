import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> discountsAddMainHelper({
  required WidgetTester tester,
  bool hasField = true,
}) async {
  final matcher = hasField ? findsOneWidget : findsNothing;

  if (hasField) {
    await scrollingHelper(
      tester: tester,
      itemKey: KWidgetkeys.screen.discountsAdd.titleField,
    );
  }

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.titleField),
    matcher,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.discountsField),
    matcher,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.eligibilityField),
    matcher,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.linkField),
    matcher,
  );
}
