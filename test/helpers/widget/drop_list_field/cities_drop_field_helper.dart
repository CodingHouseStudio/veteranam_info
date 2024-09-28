import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> citiesDropFieldHelper({
  required WidgetTester tester,
  required String text,
  required Key textFieldKey,
  int fieldIndex = 0,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.citiesDropField.widget,
  );

  expect(find.byKey(KWidgetkeys.widget.citiesDropField.widget), findsWidgets);

  await multiDropFieldHelper(
    tester: tester,
    text: text,
    textFieldKey: textFieldKey,
    fieldIndex: fieldIndex,
    itemTextWidget: () => tester
        .widget<Text>(
          find.byKey(KWidgetkeys.widget.citiesDropField.city).first,
        )
        .data,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropListField.widget).at(fieldIndex),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.citiesDropField.city), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.citiesDropField.region), findsWidgets);

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropListField.activeIcon).first,
    warnIfMissed: false,
  );
}
