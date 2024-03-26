import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_mocks/test_mocks.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget, {MockGoRouter? mockGoRouter}) {
    return pumpWidget(
      mockGoRouter == null
          ? MaterialApp(
              // ignore: lines_longer_than_80_chars
              // localizationsDelegates: AppLocalizations.localizationsDelegates,
              // supportedLocales: AppLocalizations.supportedLocales,
              home: widget,
            )
          : MockGoRouterProvider(
              goRouter: mockGoRouter,
              child: MaterialApp(
                // ignore: lines_longer_than_80_chars
                // localizationsDelegates: AppLocalizations.localizationsDelegates,
                // supportedLocales: AppLocalizations.supportedLocales,
                home: widget,
              ),
            ),
    );
  }
}
