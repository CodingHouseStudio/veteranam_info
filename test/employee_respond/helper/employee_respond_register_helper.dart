import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/employee_respond/bloc/employee_respond_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IWorkRepository mockWorkRepository;
late IDataPickerRepository mockDataPickerRepository;
void employeeRespondWidgetTestRegister() {
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

  registerFactory(
    () => EmployeeRespondBloc(
      employeeRespondRepository: mockWorkRepository,
      dataPickerRepository: mockDataPickerRepository,
    ),
  );
}
