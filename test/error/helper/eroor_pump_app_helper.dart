import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> errorPumpAppHelper({
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  if (mockGoRouter == null) {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ErrorScreen(),
      ),
    );
  } else {
    await tester.pumpWidget(
      MockGoRouterProvider(
        goRouter: mockGoRouter,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
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
