import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> errorInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.error.title),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.error.button),
    findsOneWidget,
  );
}
