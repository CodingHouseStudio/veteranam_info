import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';
import 'widget/widget.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.workEmployee} ', () {
    late IWorkRepository mockWorkRepository;
    late WorkEmployeeWatcherBloc workEmployeeWatcherBloc;
    setUp(() {
      mockWorkRepository = MockIWorkRepository();
      when(mockWorkRepository.getWorks())
          .thenAnswer((invocation) => Stream.value(KTestText.workModelItems));
    });
    void registerWorkEmployeeBloc() {
      workEmployeeWatcherBloc = WorkEmployeeWatcherBloc(
        workRepository: mockWorkRepository,
      );
      if (GetIt.I.isRegistered<WorkEmployeeWatcherBloc>()) {
        GetIt.I.unregister<WorkEmployeeWatcherBloc>();
      }
      GetIt.I.registerSingleton<WorkEmployeeWatcherBloc>(
        workEmployeeWatcherBloc,
      );
    }

    testWidgets('${KGroupText.intial} ', (tester) async {
      registerWorkEmployeeBloc();
      await tester.pumpApp(const WorkEmployeeScreen());

      expect(
        find.byKey(KWidgetkeys.screen.workEmployee.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp,
      );

      expect(
        find.byKey(KWidgetkeys.screen.workEmployee.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.workEmployee.subtitle),
        findsOneWidget,
      );

      await workEmployeeFilterHelper(tester);

      expect(
        find.byKey(KWidgetkeys.screen.workEmployee.cards),
        findsWidgets,
      );

      expect(
        find.byKey(KWidgetkeys.screen.workEmployee.mockDataButton),
        findsNothing,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp500,
      );

      expect(
        find.byKey(KWidgetkeys.screen.workEmployee.pagination),
        findsOneWidget,
      );

      await paginationTest(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        registerWorkEmployeeBloc();
        await tester.pumpApp(
          const WorkEmployeeScreen(),
          mockGoRouter: mockGoRouter,
        );

        expect(
          find.byKey(KWidgetkeys.screen.workEmployee.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();

        await scrollingHelper(
          tester: tester,
          offset: KTestConstants.scrollingUp,
        );

        expect(
          find.byKey(KWidgetkeys.screen.workEmployee.title),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.workEmployee.subtitle),
          findsOneWidget,
        );

        await workEmployeeFilterHelper(tester);

        expect(
          find.byKey(KWidgetkeys.screen.workEmployee.cards),
          findsWidgets,
        );

        expect(
          find.byKey(KWidgetkeys.screen.workEmployee.mockDataButton),
          findsNothing,
        );

        await scrollingHelper(
          tester: tester,
          offset: KTestConstants.scrollingDown,
        );

        await scrollingHelper(
          tester: tester,
          offset: KTestConstants.scrollingDown,
        );

        await scrollingHelper(
          tester: tester,
          offset: KTestConstants.scrollingUp500,
        );

        expect(
          find.byKey(KWidgetkeys.screen.workEmployee.pagination),
          findsOneWidget,
        );

        await paginationTest(tester);
      });
      // group('${KGroupText.goTo} ', () {
      // });
    });
  });
}
