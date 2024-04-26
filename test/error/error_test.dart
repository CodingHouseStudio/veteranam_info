import 'package:flutter/material.dart';
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
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ErrorScreen(),
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
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: ErrorScreen(),
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
            MockGoRouterProvider(
              goRouter: mockGoRouter,
              child: const MaterialApp(
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                home: ErrorScreen(),
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
