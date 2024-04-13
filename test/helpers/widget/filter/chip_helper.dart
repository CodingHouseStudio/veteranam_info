import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> chipHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.chip.widget), findsWidgets);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.chip.widget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.chip.widget).first,
  );
  await tester.pumpAndSettle();

  late var chip = tester.widget<FilterChip>(
    find.byKey(KWidgetkeys.widget.chip.widget).first,
  );

  expect(chip.selected, isTrue);

  await filterPopupMenuHelper(tester);

  chip = tester.widget<FilterChip>(
    find.byKey(KWidgetkeys.widget.chip.widget).first,
  );

  expect(chip.selected, isFalse);
}
