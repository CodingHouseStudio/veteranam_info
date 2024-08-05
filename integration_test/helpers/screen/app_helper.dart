import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/app.dart';
import 'package:veteranam/shared/shared.dart';

/// COMMENT: Helpers intial app in integration tests
Future<void> appHelper(WidgetTester tester) async {
  await tester.pumpWidget(const App());

  final finder = find.byKey(KWidgetkeys.screen.app.screen);

  log('Loading App...');

  while (finder.evaluate().isEmpty) {
    await tester.pumpAndSettle();
  }

  log('App Loaded');

  expect(
    find.byKey(KWidgetkeys.screen.app.screen),
    findsOneWidget,
  );
}

/// FOLDER FILES COMMENT: Files for widgets test or helper for test
