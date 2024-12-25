import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> discountsAddDescriptionHelper({
  required WidgetTester tester,
  bool hasField = true,
}) async {
  final matcher = hasField ? findsOneWidget : findsNothing;

  if (hasField) {
    await scrollingHelper(
      tester: tester,
      itemKey: KWidgetkeys.screen.discountsAdd.descriptionField,
    );
  }

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.descriptionField),
    matcher,
  );
  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.exclusionField),
    matcher,
  );
}
