import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/error/view/error_view.dart';
import 'package:veteranam/l10n/l10n.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> errorPumpAppHelper({
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  if (mockGoRouter == null) {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: locale,
        supportedLocales: supportedLocales,
        home: ErrorScreen(),
      ),
    );
  } else {
    await tester.pumpWidget(
      MockGoRouterProvider(
        goRouter: mockGoRouter,
        child: const MaterialApp(
          localizationsDelegates: locale,
          supportedLocales: supportedLocales,
          home: ErrorScreen(),
        ),
      ),
    );
  }

  expect(
    find.byKey(KWidgetkeys.screen.error.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
