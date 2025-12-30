import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> discountsAddDetailHelper({
  required WidgetTester tester,
  bool hasField = true,
  bool checkHelper = false,
}) async {
  final matcher = hasField ? findsOneWidget : findsNothing;

  if (hasField) {
    await scrollingHelper(
      tester: tester,
      itemKey: DiscountsAddKeys.categoryField,
    );
  }

  expect(
    find.byKey(DiscountsAddKeys.categoryField),
    matcher,
  );

  if (hasField && checkHelper) {
    await multiDropFieldHelper(
      tester: tester,
      text: KTestVariables.field,
      textFieldKey: DiscountsAddKeys.categoryField,
    );
  }

  expect(
    find.byKey(DiscountsAddKeys.cityField),
    matcher,
  );

  if (hasField && checkHelper) {
    await citiesDropFieldHelper(
      tester: tester,
      text: KTestVariables.field,
      textFieldKey: DiscountsAddKeys.cityField,
      // fieldIndex: 1,
    );
  }

  expect(
    find.byKey(DiscountsAddKeys.periodField),
    matcher,
  );

  if (hasField && checkHelper) {
    expect(
      find.byKey(DiscountsAddKeys.indefinitelySwitcher),
      findsOneWidget,
    );

    expect(
      find.byKey(DiscountsAddKeys.indefinitelyText),
      findsOneWidget,
    );

    await switchHelper(tester: tester, isActive: true, elementIndex: 1);
  }
}
