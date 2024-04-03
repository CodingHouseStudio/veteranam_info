import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: KWidgetkeys.screen.app.screen,
      theme: themeData,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
