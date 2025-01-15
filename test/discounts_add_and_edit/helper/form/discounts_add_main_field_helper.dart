import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> discountsAddMainHelper({
  required WidgetTester tester,
  bool hasField = true,
}) async {
  final matcher = hasField ? findsOneWidget : findsNothing;

  if (hasField) {
    await scrollingHelper(
      tester: tester,
      itemKey: DiscountsAddKeys.titleField,
    );
  }

  expect(
    find.byKey(DiscountsAddKeys.titleField),
    matcher,
  );

  expect(
    find.byKey(DiscountsAddKeys.discountsField),
    matcher,
  );

  expect(
    find.byKey(DiscountsAddKeys.eligibilityField),
    matcher,
  );

  expect(
    find.byKey(DiscountsAddKeys.linkField),
    matcher,
  );
}
