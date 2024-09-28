import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> multiDropFieldRemoveHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.multiDropField.chips), findsWidgets);

  await tester.tap(find.byKey(KWidgetkeys.widget.multiDropField.chips).first);

  await tester.pumpAndSettle();
}
