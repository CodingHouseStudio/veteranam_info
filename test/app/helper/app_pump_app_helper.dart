import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/app.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> appPumpAppHelper(
  WidgetTester tester,
) async {
  await tester.pumpWidget(const App());

  await tester.pumpAndSettle();

  expect(
    find.byKey(AppKeys.screen),
    findsOneWidget,
  );
}
