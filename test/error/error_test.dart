import 'package:flutter/material.dart';
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
  group(KScreenName.app, () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ErrorScreen()));

      expect(
        find.byKey(KWidgetkeys.screenKeys.errorScreenKeys.screen),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screenKeys.errorScreenKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screenKeys.errorScreenKeys.button),
        findsOneWidget,
      );
    });
    group('Mock Go Router', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('renders initial', (tester) async {
        await tester.pumpWidget(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const MaterialApp(home: ErrorScreen()),
          ),
        );

        expect(
          find.byKey(KWidgetkeys.screenKeys.errorScreenKeys.screen),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screenKeys.errorScreenKeys.title),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screenKeys.errorScreenKeys.button),
          findsOneWidget,
        );
      });

      group('go to', () {
        testWidgets(KScreenName.home, (tester) async {
          await tester.pumpApp(
            MockGoRouterProvider(
              goRouter: mockGoRouter,
              child: const MaterialApp(home: ErrorScreen()),
            ),
          );

          expect(
            find.byKey(KWidgetkeys.screenKeys.errorScreenKeys.button),
            findsOneWidget,
          );

          await tester
              .tap(find.byKey(KWidgetkeys.screenKeys.errorScreenKeys.button));

          verify(
            () => mockGoRouter.go(
              KRoute.home.path,
            ),
          ).called(1);
        });
      });
    });
  });
}
