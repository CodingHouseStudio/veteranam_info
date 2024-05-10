import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> informationFilterHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.screen.information.filter), findsOneWidget);

  await chipHelper(tester);
}
