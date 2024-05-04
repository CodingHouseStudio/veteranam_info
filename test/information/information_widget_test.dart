import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';
import 'information_widget/information_widget.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.information} ', () {
    late IInformationRepository mockInformationRepository;
    late InformationWatcherBloc informationBloc;
    setUp(() {
      mockInformationRepository = MockIInformationRepository();
      when(mockInformationRepository.getInformationItems()).thenAnswer(
        (invocation) => Stream.value(KTestText.informationModelItems),
      );
    });
    void registerInformationBloc() {
      informationBloc = InformationWatcherBloc(
        informationRepository: mockInformationRepository,
      );
      if (GetIt.I.isRegistered<InformationWatcherBloc>()) {
        GetIt.I.unregister<InformationWatcherBloc>();
      }
      GetIt.I.registerSingleton<InformationWatcherBloc>(informationBloc);
    }

    testWidgets('${KGroupText.intial} ', (tester) async {
      registerInformationBloc();
      await tester.pumpApp(const InformationScreen());

      expect(
        find.byKey(KWidgetkeys.screen.information.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp200,
      );

      expect(
        find.byKey(KWidgetkeys.screen.information.button),
        findsOneWidget,
      );

      await changeWindowSizeHelper(tester: tester);

      expect(
        find.byKey(KWidgetkeys.screen.information.buttonIcon),
        findsOneWidget,
      );

      await changeWindowSizeHelper(tester: tester, setDefaultSize: true);

      expect(
        find.byKey(KWidgetkeys.screen.information.buttonIcon),
        findsNothing,
      );

      expect(
        find.byKey(KWidgetkeys.screen.information.buttonMock),
        findsNothing,
      );

      expect(
        find.byKey(KWidgetkeys.screen.information.card),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp,
      );

      expect(
        find.byKey(KWidgetkeys.screen.information.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.information.title),
        findsOneWidget,
      );

      await informationFilterHelper(tester);

      await newsCardHelper(tester: tester);
    });

    testWidgets('News list load and filter', (tester) async {
      registerInformationBloc();
      await tester.pumpApp(const InformationScreen());

      expect(
        find.byKey(KWidgetkeys.screen.information.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      expect(find.byKey(KWidgetkeys.widget.newsCard.title), findsOneWidget);

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.information.button,
        offset: KTestConstants.scrollingUp200,
      );

      expect(find.byKey(KWidgetkeys.screen.information.button), findsOneWidget);

      await tester.tap(find.byKey(KWidgetkeys.screen.information.button));

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.widget.newsCard.title,
        offset: KTestConstants.scrollingUp,
      );

      final widgets = find.byKey(KWidgetkeys.widget.newsCard.title);

      expect(widgets, findsWidgets);

      expect(widgets.evaluate().length, greaterThan(1));

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp,
      );

      await informationFilterHelper(tester);

      expect(find.byKey(KWidgetkeys.widget.newsCard.title), findsOneWidget);

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.information.button,
        offset: KTestConstants.scrollingUp500,
      );

      await tester.tap(find.byKey(KWidgetkeys.screen.information.button));

      await tester.pumpAndSettle();

      final widgetsTwoTap = find.byKey(KWidgetkeys.widget.newsCard.title);

      expect(widgets.evaluate().length, widgetsTwoTap.evaluate().length);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        registerInformationBloc();
        await tester.pumpApp(
          const InformationScreen(),
          mockGoRouter: mockGoRouter,
        );

        expect(
          find.byKey(KWidgetkeys.screen.information.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();

        await scrollingHelper(
          tester: tester,
          offset: KTestConstants.scrollingDown,
        );

        await scrollingHelper(
          tester: tester,
          itemKey: KWidgetkeys.screen.information.button,
          offset: KTestConstants.scrollingUp200,
        );

        expect(
          find.byKey(KWidgetkeys.screen.information.button),
          findsOneWidget,
        );

        await changeWindowSizeHelper(tester: tester);

        expect(
          find.byKey(KWidgetkeys.screen.information.buttonIcon),
          findsOneWidget,
        );

        await changeWindowSizeHelper(tester: tester, setDefaultSize: true);

        expect(
          find.byKey(KWidgetkeys.screen.information.buttonIcon),
          findsNothing,
        );

        expect(
          find.byKey(KWidgetkeys.screen.information.buttonMock),
          findsNothing,
        );

        expect(
          find.byKey(KWidgetkeys.screen.information.card),
          findsOneWidget,
        );

        await scrollingHelper(
          tester: tester,
          itemKey: KWidgetkeys.screen.information.title,
          offset: KTestConstants.scrollingUp,
        );

        expect(
          find.byKey(KWidgetkeys.screen.information.title),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.information.subtitle),
          findsOneWidget,
        );

        await informationFilterHelper(tester);

        await newsCardHelper(tester: tester);
      });

      // group('${KGroupText.goTo} ', () {
      // });
    });
  });
}
