import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.employeeRespond} ', () {
    late IWorkRepository mockWorkRepository;
    late ImagePicker mockImagePicker;
    setUp(() {
      ExtendedDateTime.id = KTestText.employeeRespondModel.id;
      mockWorkRepository = MockIWorkRepository();
      mockImagePicker = MockImagePicker();
      when(mockImagePicker.pickMedia()).thenAnswer(
        (realInvocation) async => XFile(
          KTestText.downloadURL,
        ),
      );
      EmployeeRespondBloc.filePickerValue = mockImagePicker;

      when(mockWorkRepository.sendRespond(KTestText.employeeRespondModel))
          .thenAnswer((invocation) async => const Right(true));

      when(
        mockWorkRepository.sendRespond(
          KTestText.employeeRespondWithoudResumeModel,
        ),
      ).thenAnswer((invocation) async => const Right(true));
    });
    testWidgets('${KGroupText.initial} ', (tester) async {
      await employeeRespondPumpAppHelper(
        tester: tester,
        mockWorkRepository: mockWorkRepository,
      );

      await employeeRespondInitialHelper(tester);
    });
    testWidgets('Fill Form Incorrect Send', (tester) async {
      await employeeRespondPumpAppHelper(
        tester: tester,
        mockWorkRepository: mockWorkRepository,
      );

      await formIncorrectSendHelper(tester);
    });
    testWidgets('Fill Form Correct Send', (tester) async {
      await employeeRespondPumpAppHelper(
        tester: tester,
        mockWorkRepository: mockWorkRepository,
      );

      await formCorrectSendHelper(tester);
    });
    testWidgets('Fill Form Without Resume Send', (tester) async {
      await employeeRespondPumpAppHelper(
        tester: tester,
        mockWorkRepository: mockWorkRepository,
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
        );
        await employeeRespondInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('${KRoute.workEmployee.name} ', (tester) async {
          await employeeRespondPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockWorkRepository: mockWorkRepository,
          );
          await cancelHelper(mockGoRouter: mockGoRouter, tester: tester);
        });
      });
    });
  });
}
