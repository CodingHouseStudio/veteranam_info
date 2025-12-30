import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> citiesDropFieldHelper({
  required WidgetTester tester,
  required String text,
  required Key textFieldKey,
  // int fieldIndex = 0,
  // Key? fieldKey,
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
    // fieldKey: fieldKey,
    // itemTextWidget: () => tester
    //     .widget<Text>(
    //       find.byKey(CitiesDropFieldKeys.city).first,
    //     )
    //     .data,
  );

  await tester.tap(
    find.byKey(textFieldKey),
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
