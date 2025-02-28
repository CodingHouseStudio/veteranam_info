import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/app.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

/// COMMENT: Helpers intial app in integration tests
Future<void> appHelper(WidgetTester tester) async {
  await tester.pumpWidget(const App());

  log('Loading App...', name: 'Integation Tests');

  while (find.byKey(NawbarKeys.widget).evaluate().isEmpty) {
    await tester.pumpAndSettle(const Duration(milliseconds: 200));
  }

  log('App Loaded', name: 'Integation Tests');

  // ignore: avoid_print
  print('Integration tests start ${DateTime.now()}');

  expect(
    find.byKey(AppKeys.screen),
    findsOneWidget,
  );
}

/// FOLDER FILES COMMENT: Files for widgets test or helper for test
