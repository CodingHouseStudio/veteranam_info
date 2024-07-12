import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../text_dependency.dart';
import 'helper/employee_respond_initial_helper.dart';
import 'helper/employee_respond_pump_app_helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.employeeRespond} ', () {
    late IWorkRepository mockWorkRepository;
    setUp(() {
      mockWorkRepository = MockIWorkRepository();

      when(mockWorkRepository.sendRespond(KTestText.employeeRespondModel))
          .thenAnswer((invocation) async => const Right(true));
    });
    testWidgets('${KGroupText.intial} ', (tester) async {
      await employeeRespondPumpAppHelper(
        tester: tester,
        mockWorkRepository: mockWorkRepository,
      );

      await employeeRespondInitialHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await employeeRespondPumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockWorkRepository: mockWorkRepository,
        );
        await employeeRespondInitialHelper(tester);
      });
    });
  });
}
