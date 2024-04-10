import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

part 'chip_helper.dart';
part 'drop_chip_helper.dart';
part 'filter_popup_menu_helper.dart';

Future<void> filterBoxHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.filter.widget), findsWidgets);

  await _chipHelper(tester);

  await _dropChipHelper(tester);
}
