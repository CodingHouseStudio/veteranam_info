import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> filterChipHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.filterChip.widget), findsWidgets);

  await chipHelper(tester);
}