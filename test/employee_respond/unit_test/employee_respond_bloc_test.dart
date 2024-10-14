import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.employeeRespond} ${KGroupText.bloc}', () {
    late EmployeeRespondBloc employeeRespondBloc;
    late IWorkRepository mockWorkRepository;
    late IDataPickerRepository mockDataPickerRepository;
    setUp(() {
      ExtendedDateTime.id = KTestText.employeeRespondModel.id;
      mockDataPickerRepository = MockIDataPickerRepository();

      when(mockDataPickerRepository.getFile).thenAnswer(
        (realInvocation) async => KTestText.imagePickerItem,
      );

      mockWorkRepository = MockIWorkRepository();
      employeeRespondBloc = EmployeeRespondBloc(
        employeeRespondRepository: mockWorkRepository,
        dataPickerRepository: mockDataPickerRepository,
      );
    });
    blocTest<EmployeeRespondBloc, EmployeeRespondState>(
      'emits [EmployeeRespondState.initial(), EmployeeRespondState.success()]'
      ' when update email, phone, load resume and save',
      build: () => employeeRespondBloc,
      act: (bloc) async {
        when(
          mockWorkRepository.sendRespond(
            file: KTestText.imagePickerItem,
            respond: KTestText.employeeRespondModel,
          ),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        bloc
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
          ..add(const EmployeeRespondEvent.loadResumeClicked());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<EmployeeRespondState>(
              (state) => state.email.isValid,
            ),
            predicate<EmployeeRespondState>(
              (state) => state.phoneNumber.isValid,
            ),
            predicate<EmployeeRespondState>(
              (state) => state.resume.isValid,
            ),
          ]),
          reason: 'Wait resume get',
        );
        bloc.add(const EmployeeRespondEvent.save());
      },
      expect: () async => [
        EmployeeRespondState(
          email: EmailFieldModel.dirty(
            KTestText.employeeRespondModel.email,
          ),
          phoneNumber: const PhoneNumberFieldModel.pure(),
          resume: const ResumeFieldModel.pure(),
          noResume: false,
          formState: EmployeeRespondEnum.inProgress,
          failure: null,
        ),
        EmployeeRespondState(
          email: EmailFieldModel.dirty(
            KTestText.employeeRespondModel.email,
          ),
          phoneNumber: PhoneNumberFieldModel.dirty(
            KTestText.employeeRespondModel.phoneNumber,
          ),
          resume: const ResumeFieldModel.pure(),
          noResume: false,
          formState: EmployeeRespondEnum.inProgress,
          failure: null,
        ),
        EmployeeRespondState(
          email: EmailFieldModel.dirty(
            KTestText.employeeRespondModel.email,
          ),
          phoneNumber: PhoneNumberFieldModel.dirty(
            KTestText.employeeRespondModel.phoneNumber,
          ),
          resume: ResumeFieldModel.dirty(
            KTestText.imagePickerItem,
          ),
          noResume: false,
          formState: EmployeeRespondEnum.inProgress,
          failure: null,
        ),
        const EmployeeRespondState(
          email: EmailFieldModel.pure(),
          phoneNumber: PhoneNumberFieldModel.pure(),
          resume: ResumeFieldModel.pure(),
          noResume: false,
          formState: EmployeeRespondEnum.success,
          failure: null,
        ),
      ],
    );
    blocTest<EmployeeRespondBloc, EmployeeRespondState>(
      'emits [EmployeeRespondState.initial(), EmployeeRespondState.success()]'
      ' when update email, phone, no resume and save',
      build: () => employeeRespondBloc,
      act: (bloc) async {
        when(
          mockWorkRepository.sendRespond(
            respond: KTestText.employeeRespondWithoudResumeModel,
            file: KTestText.imagePickerItem,
          ),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        bloc
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
          ..add(const EmployeeRespondEvent.noResumeChanged())
          ..add(const EmployeeRespondEvent.save());
      },
      expect: () async => [
        EmployeeRespondState(
          email: EmailFieldModel.dirty(
            KTestText.employeeRespondModel.email,
          ),
          phoneNumber: const PhoneNumberFieldModel.pure(),
          resume: const ResumeFieldModel.pure(),
          noResume: false,
          formState: EmployeeRespondEnum.inProgress,
          failure: null,
        ),
        EmployeeRespondState(
          email: EmailFieldModel.dirty(
            KTestText.employeeRespondModel.email,
          ),
          phoneNumber: PhoneNumberFieldModel.dirty(
            KTestText.employeeRespondModel.phoneNumber,
          ),
          resume: const ResumeFieldModel.pure(),
          noResume: false,
          formState: EmployeeRespondEnum.inProgress,
          failure: null,
        ),
        EmployeeRespondState(
          email: EmailFieldModel.dirty(
            KTestText.employeeRespondModel.email,
          ),
          phoneNumber: PhoneNumberFieldModel.dirty(
            KTestText.employeeRespondModel.phoneNumber,
          ),
          resume: const ResumeFieldModel.pure(),
          noResume: true,
          formState: EmployeeRespondEnum.inProgress,
          failure: null,
        ),
        const EmployeeRespondState(
          email: EmailFieldModel.pure(),
          phoneNumber: PhoneNumberFieldModel.pure(),
          resume: ResumeFieldModel.pure(),
          noResume: false,
          formState: EmployeeRespondEnum.success,
          failure: null,
        ),
      ],
    );
    blocTest<EmployeeRespondBloc, EmployeeRespondState>(
      'emits [EmployeeRespondState.initial(), EmployeeRespondState.success()]'
      ' when update email, phone, no resume and save ${KGroupText.failure}',
      build: () => employeeRespondBloc,
      act: (bloc) async {
        when(
          mockWorkRepository.sendRespond(
            respond: KTestText.employeeRespondWithoudResumeModel,
            file: KTestText.imagePickerItem,
          ),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        bloc
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
          ..add(const EmployeeRespondEvent.noResumeChanged())
          ..add(const EmployeeRespondEvent.save());
      },
      expect: () async => [
        EmployeeRespondState(
          email: EmailFieldModel.dirty(
            KTestText.employeeRespondModel.email,
          ),
          phoneNumber: const PhoneNumberFieldModel.pure(),
          resume: const ResumeFieldModel.pure(),
          noResume: false,
          formState: EmployeeRespondEnum.inProgress,
          failure: null,
        ),
        EmployeeRespondState(
          email: EmailFieldModel.dirty(
            KTestText.employeeRespondModel.email,
          ),
          phoneNumber: PhoneNumberFieldModel.dirty(
            KTestText.employeeRespondModel.phoneNumber,
          ),
          resume: const ResumeFieldModel.pure(),
          noResume: false,
          formState: EmployeeRespondEnum.inProgress,
          failure: null,
        ),
        EmployeeRespondState(
          email: EmailFieldModel.dirty(
            KTestText.employeeRespondModel.email,
          ),
          phoneNumber: PhoneNumberFieldModel.dirty(
            KTestText.employeeRespondModel.phoneNumber,
          ),
          resume: const ResumeFieldModel.pure(),
          noResume: true,
          formState: EmployeeRespondEnum.inProgress,
          failure: null,
        ),
        EmployeeRespondState(
          email: EmailFieldModel.dirty(
            KTestText.employeeRespondModel.email,
          ),
          phoneNumber: PhoneNumberFieldModel.dirty(
            KTestText.employeeRespondModel.phoneNumber,
          ),
          resume: const ResumeFieldModel.pure(),
          noResume: true,
          formState: EmployeeRespondEnum.inProgress,
          failure: EmployeeRespondFailure.error,
        ),
      ],
    );
  });
}
