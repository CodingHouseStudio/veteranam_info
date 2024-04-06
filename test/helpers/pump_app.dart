import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';

import '../test_mocks/test_mocks.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget, {MockGoRouter? mockGoRouter}) {
    return pumpWidget(
      BlocProvider(
        create: (context) => GetIt.I.get<LanguageCubit>()..initLanguage(),
        child: BlocBuilder<LanguageCubit, Language?>(
          builder: (context, state) => mockGoRouter == null
              ? MaterialApp(
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  locale: state?.value,
                  supportedLocales: AppLocalizations.supportedLocales,
                  home: ScaffoldWithNavBar(navigationShell: widget),
                )
              : MockGoRouterProvider(
                  goRouter: mockGoRouter,
                  child: MaterialApp(
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    locale: state?.value,
                    supportedLocales: AppLocalizations.supportedLocales,
                    home: ScaffoldWithNavBar(navigationShell: widget),
                  ),
                ),
        ),
      ),
    );
  }
}
