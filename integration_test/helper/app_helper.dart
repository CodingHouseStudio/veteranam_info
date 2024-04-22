import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/app.dart';
import 'package:kozak/shared/shared.dart';

/// COMMENT: Helpers intial app in integration tests
Future<void> appHelper(WidgetTester tester) async {
  await tester.pumpWidget(const App());

  expect(
    find.byKey(KWidgetkeys.screen.app.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle(const Duration(seconds: 2));
}

/// FOLDER FILES COMMENT: Files for widgets test or helper for test
