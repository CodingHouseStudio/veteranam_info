import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../text_dependency.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.error} ', () {
    testWidgets('${KGroupText.intial} ', (tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => GetIt.I.get<LanguageCubit>()..initLanguage(),
          child: BlocBuilder<LanguageCubit, Language?>(
            builder: (context, state) {
              return MaterialApp(
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                locale: state?.value,
                supportedLocales: AppLocalizations.supportedLocales,
                home: const ErrorScreen(),
              );
            },
          ),
        ),
      );

      expect(
        find.byKey(KWidgetkeys.screen.error.screen),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.error.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.error.button),
        findsOneWidget,
      );
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await tester.pumpWidget(
          BlocProvider(
            create: (context) => GetIt.I.get<LanguageCubit>()..initLanguage(),
            child: BlocBuilder<LanguageCubit, Language?>(
              builder: (context, state) {
                return MaterialApp(
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  locale: state?.value,
                  supportedLocales: AppLocalizations.supportedLocales,
                  home: const ErrorScreen(),
                );
              },
            ),
          ),
        );

        expect(
          find.byKey(KWidgetkeys.screen.error.screen),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.error.title),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.error.button),
          findsOneWidget,
        );
      });

      group('${KGroupText.goTo} ', () {
        testWidgets(KScreenBlocName.home, (tester) async {
          await tester.pumpWidget(
            BlocProvider(
              create: (context) => GetIt.I.get<LanguageCubit>()..initLanguage(),
              child: BlocBuilder<LanguageCubit, Language?>(
                builder: (context, state) {
                  return MockGoRouterProvider(
                    goRouter: mockGoRouter,
                    child: MaterialApp(
                      localizationsDelegates:
                          AppLocalizations.localizationsDelegates,
                      locale: state?.value,
                      supportedLocales: AppLocalizations.supportedLocales,
                      home: const ErrorScreen(),
                    ),
                  );
                },
              ),
            ),
          );

          expect(
            find.byKey(KWidgetkeys.screen.error.button),
            findsOneWidget,
          );

          await tester.tap(find.byKey(KWidgetkeys.screen.error.button));

          verify(
            () => mockGoRouter.goNamed(
              KRoute.home.name,
            ),
          ).called(1);
        });
      });
    });
  });
}
