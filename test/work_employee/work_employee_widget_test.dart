import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.workEmployee} ', () {
    setUp(workEmployeeWidgetTestRegister);
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(mockWorkRepository.getWorks()).thenAnswer(
          (invocation) => Stream.error(Exception(KGroupText.failureGet)),
        );
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
        await workEmployeePumpAppHelper(
          tester,
        );

        await workEmployeeFailureHelper(tester);
      });
    });
    group('${KGroupText.getEmptyList} ', () {
      tearDown(
        () => GetIt.I.unregister<IWorkRepository>(),
      );

      setUp(() {
        when(mockWorkRepository.getWorks())
            .thenAnswer((invocation) => Stream.value([]));

        when(mockWorkRepository.addMockWorks()).thenAnswer(
          (invocation) {},
        );
        if (GetIt.I.isRegistered<IWorkRepository>()) {
          GetIt.I.unregister<IWorkRepository>();
        }
        GetIt.I.registerSingleton<IWorkRepository>(
          mockWorkRepository,
        );
      });
      testWidgets('${KGroupText.mockButton} ', (tester) async {
        await workEmployeePumpAppHelper(
          tester,
        );

        await workEmployeeMockButtonHelper(tester);
      });
    });
    group('${KGroupText.getList} ', () {
      setUp(() {
        when(mockWorkRepository.getWorks()).thenAnswer(
          (invocation) => Stream.value(KTestVariables.workModelItems),
        );
      });

      testWidgets('${KGroupText.initial} ', (tester) async {
        await workEmployeePumpAppHelper(
          tester,
        );

        await workEmployeeInitialHelper(tester);
      });
      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await workEmployeePumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await workEmployeeInitialHelper(tester);
        });
        group('${KGroupText.goTo} ', () {
          testWidgets('${KRoute.employeeRespond.name} ', (tester) async {
            await workEmployeePumpAppHelper(
              tester,
              mockGoRouter: mockGoRouter,
            );

            await workCardNavigationHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });
        });
      });
      group('${KGroupText.smallList} ', () {
        setUp(() {
          when(mockWorkRepository.getWorks()).thenAnswer(
            (invocation) =>
                Stream.value(KTestVariables.workModelItems.sublist(0, 1)),
          );
        });
        testWidgets('Only one card', (tester) async {
          await workEmployeePumpAppHelper(
            tester,
          );

          expect(
            find.byKey(WorkEmployeeKeys.cards),
            findsOneWidget,
          );
        });
      });
    });
  });
}
