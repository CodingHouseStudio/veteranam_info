import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.workEmployee} ', () {
    late IWorkRepository mockWorkRepository;
    setUp(() {
      mockWorkRepository = MockIWorkRepository();
      when(mockWorkRepository.getWorks())
          .thenAnswer((invocation) => Stream.value(KTestText.workModelItems));
    });

    testWidgets('${KGroupText.intial} ', (tester) async {
      await workEmployeePumpAppHelper(
        mockWorkRepository: mockWorkRepository,
        tester: tester,
      );

      await workEmployeeInitialHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await workEmployeePumpAppHelper(
          mockWorkRepository: mockWorkRepository,
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await workEmployeeInitialHelper(tester);
      });
      // group('${KGroupText.goTo} ', () {
      // });
    });
  });
}
