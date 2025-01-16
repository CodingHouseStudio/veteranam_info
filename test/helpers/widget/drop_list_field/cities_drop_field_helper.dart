import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> citiesDropFieldHelper({
  required WidgetTester tester,
  required String text,
  required Key textFieldKey,
  int fieldIndex = 0,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: CitiesDropFieldKeys.widget,
  );

  expect(find.byKey(CitiesDropFieldKeys.widget), findsWidgets);

  await multiDropFieldHelper(
    tester: tester,
    text: text,
    textFieldKey: textFieldKey,
    fieldIndex: fieldIndex,
    itemTextWidget: () => tester
        .widget<Text>(
          find.byKey(CitiesDropFieldKeys.city).first,
        )
        .data,
  );

  await tester.tap(
    find.byKey(DropListFieldKeys.widget).at(fieldIndex),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  expect(find.byKey(CitiesDropFieldKeys.city), findsWidgets);

  expect(find.byKey(CitiesDropFieldKeys.region), findsWidgets);

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(DropListFieldKeys.activeIcon).first,
    warnIfMissed: false,
  );
}
