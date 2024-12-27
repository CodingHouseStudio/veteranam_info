import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.employeeRespond} ', () {
    late IWorkRepository mockWorkRepository;
    late IDataPickerRepository mockDataPickerRepository;
    setUp(() {
      ExtendedDateTime.id = KTestVariables.employeeRespondModelModel.id;
      mockWorkRepository = MockIWorkRepository();
      mockDataPickerRepository = MockIDataPickerRepository();
      when(mockDataPickerRepository.getFile).thenAnswer(
        (realInvocation) async => KTestVariables.filePickerItem,
      );
      // EmployeeRespondBloc.filePickerValue = mockImagePicker;

      when(
        mockWorkRepository.sendRespond(
          respond: KTestVariables.employeeRespondModel,
          file: KTestVariables.filePickerItem,
        ),
      ).thenAnswer((invocation) async => const Right(true));

      when(
        mockWorkRepository.sendRespond(
          respond: KTestVariables.employeeRespondWithoudResumeModel,
          file: null,
        ),
      ).thenAnswer((invocation) async => const Right(true));
    });
    testWidgets('${KGroupText.initial} ', (tester) async {
      await employeeRespondPumpAppHelper(
        tester: tester,
        mockWorkRepository: mockWorkRepository,
        mockDataPickerRepository: mockDataPickerRepository,
      );

      await employeeRespondInitialHelper(tester);
    });
    testWidgets('Fill Form Incorrect Send', (tester) async {
      await employeeRespondPumpAppHelper(
        tester: tester,
        mockWorkRepository: mockWorkRepository,
        mockDataPickerRepository: mockDataPickerRepository,
      );

      await formIncorrectSendHelper(tester);
    });
    testWidgets('Fill Form Correct Send', (tester) async {
      await employeeRespondPumpAppHelper(
        tester: tester,
        mockWorkRepository: mockWorkRepository,
        mockDataPickerRepository: mockDataPickerRepository,
      );

      await formCorrectSendHelper(tester);
    });
    testWidgets('Fill Form Without Resume Send', (tester) async {
      await employeeRespondPumpAppHelper(
        tester: tester,
        mockWorkRepository: mockWorkRepository,
        mockDataPickerRepository: mockDataPickerRepository,
      );

      await formWithoundResumeSendHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await employeeRespondPumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockWorkRepository: mockWorkRepository,
          mockDataPickerRepository: mockDataPickerRepository,
        );

        await employeeRespondInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('${KRoute.workEmployee.name} ', (tester) async {
          await employeeRespondPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockWorkRepository: mockWorkRepository,
            mockDataPickerRepository: mockDataPickerRepository,
          );
          await cancelHelper(mockGoRouter: mockGoRouter, tester: tester);
        });
      });
    });
  });
}
