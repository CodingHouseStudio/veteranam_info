import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  group('${KScreenBlocName.employeeRespond} ${KGroupText.bloc}', () {
    late EmployeeRespondBloc employeeRespondBloc;
    late IWorkRepository mockWorkRepository;
    late ImagePicker mockImagePicker;
    setUp(() {
      mockImagePicker = MockImagePicker();
      when(mockImagePicker.pickMedia()).thenAnswer(
        (realInvocation) async => XFile(
          KTestText.employeeRespondModel.resume.toString(),
        ),
      );
      EmployeeRespondBloc.filePickerValue = mockImagePicker;
      mockWorkRepository = MockIWorkRepository();
      when(mockWorkRepository.sendRespond(KTestText.employeeRespondModel))
          .thenAnswer(
        (_) async => const Right(true),
      );
      employeeRespondBloc = EmployeeRespondBloc(
        employeeRespondRepository: mockWorkRepository,
      );
    });
    blocTest<EmployeeRespondBloc, EmployeeRespondState>(
      'emits [EmployeeRespondState.initial(), EmployeeRespondState.success()]'
      ' when load employeeResponModel list',
      build: () => employeeRespondBloc,
      act: (bloc) => bloc
        ..add(
          EmployeeRespondEvent.emailUpdated(
            KTestText.employeeRespondModel.email,
          ),
        )
        ..add(
          EmployeeRespondEvent.phoneUpdated(
            KTestText.employeeRespondModel.phoneNumber,
          ),
        )
        ..add(const EmployeeRespondEvent.loadResumeClicked())
      // ..add(const EmployeeRespondEvent.noResumeChanged())
      // ..add(const EmployeeRespondEvent.save()),
      ,
      expect: () async => [
        predicate<EmployeeRespondState>(
          (state) =>
              state.email ==
              EmailFieldModel.dirty(
                KTestText.employeeRespondModel.email,
              ),
        ),
        predicate<EmployeeRespondState>(
          (state) =>
              state.phoneNumber ==
              PhoneNumberFieldModel.dirty(
                KTestText.employeeRespondModel.phoneNumber,
              ),
        ),
        predicate<EmployeeRespondState>(
          (state) => state.resume != const ResumeFieldModel.pure(),
        ),
        // predicate<EmployeeRespondState>(
        //   (state) => state.noResume != false,
        // ),
        // predicate<EmployeeRespondState>(
        //   (state) => state.formState == EmployeeRespondEnum.success,
        // ),
      ],
    );
  });
}
