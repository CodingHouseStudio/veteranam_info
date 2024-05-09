import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../text_dependency.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.story} ', () {
    testWidgets('${KGroupText.intial} ', (tester) async {
      await tester.pumpApp(const StoryScreen());

      expect(
        find.byKey(KWidgetkeys.screen.story.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await storyCardHelper(tester: tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await tester.pumpApp(const StoryScreen(), mockGoRouter: mockGoRouter);

        expect(
          find.byKey(KWidgetkeys.screen.story.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();

        await storyCardHelper(tester: tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('All footer widget navigation', (tester) async {
          await tester.pumpApp(
            const StoryScreen(),
            mockGoRouter: mockGoRouter,
          );

          expect(
            find.byKey(KWidgetkeys.screen.story.screen),
            findsOneWidget,
          );

          await tester.pumpAndSettle();

          await footerButtonsHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
