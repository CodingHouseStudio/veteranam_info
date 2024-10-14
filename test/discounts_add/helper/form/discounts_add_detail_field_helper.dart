import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

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
      itemKey: KWidgetkeys.screen.discountsAdd.categoryField,
    );
  }

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.categoryField),
    matcher,
  );

  if (hasField && checkHelper) {
    await multiDropFieldHelper(
      tester: tester,
      text: KTestText.field,
      textFieldKey: KWidgetkeys.screen.discountsAdd.categoryField,
    );
  }

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.cityField),
    matcher,
  );

  if (hasField && checkHelper) {
    await citiesDropFieldHelper(
      tester: tester,
      text: KTestText.field,
      textFieldKey: KWidgetkeys.screen.discountsAdd.cityField,
      fieldIndex: 1,
    );
  }

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.periodField),
    matcher,
  );

  if (hasField && checkHelper) {
    expect(
      find.byKey(KWidgetkeys.screen.discountsAdd.indefinitelySwitcher),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.screen.discountsAdd.indefinitelyText),
      findsOneWidget,
    );

    await switchHelper(tester: tester, isActive: true);
  }
}
