import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import 'package:kozak/shared/shared.dart';

part 'employee_respond_bloc.freezed.dart';
part 'employee_respond_event.dart';
part 'employee_respond_state.dart';

@Injectable()
class EmployeeRespondBloc
    extends Bloc<EmployeeRespondEvent, EmployeeRespondState> {
  EmployeeRespondBloc({
    required IWorkRepository employeeRespondRepository,
  })  : _employeeRespondRepository = employeeRespondRepository,
        super(
          const EmployeeRespondState(
            email: EmailFieldModel.pure(),
            phoneNumber: PhoneNumberFieldModel.pure(),
            resume: ResumeFieldModel.pure(),
            noResume: false,
            formState: EmployeeRespondEnum.initial,
            failure: EmployeeRespondFailure.initial,
          ),
        ) {
    on<_EmailUpdated>(_onEmailUpdated);
    on<_PhoneUpdated>(_onPhoneUpdated);
    on<_Save>(_onSave);
    on<_NoResumeChanged>(_onNoResumeChanged);
    on<_LoadResumeClicked>(_onLoadResumeClicked);
  }

  final IWorkRepository _employeeRespondRepository;
  final filePicker = filePickerValue;
  static ImagePicker filePickerValue = ImagePicker();

  void _onEmailUpdated(
    _EmailUpdated event,
    Emitter<EmployeeRespondState> emit,
  ) {
    final emailFieldModel = EmailFieldModel.dirty(event.email);
    emit(
      state.copyWith(
        email: emailFieldModel,
        formState: EmployeeRespondEnum.initial,
      ),
    );
  }

  void _onPhoneUpdated(
    _PhoneUpdated event,
    Emitter<EmployeeRespondState> emit,
  ) {
    final phoneFieldModel = PhoneNumberFieldModel.dirty(event.phone);
    emit(
      state.copyWith(
        phoneNumber: phoneFieldModel,
        formState: EmployeeRespondEnum.initial,
      ),
    );
  }

  Future<void> _onSave(
    _Save event,
    Emitter<EmployeeRespondState> emit,
  ) async {
    if (Formz.validate(
      [
        state.email,
        state.phoneNumber,
      ],
    )) {
      emit(state.copyWith(formState: EmployeeRespondEnum.sendingData));
      final result = await _employeeRespondRepository.sendRespond(
        EmployeeRespondModel(
          id: ExtendedDateTime.id,
          email: state.email.value,
          resume: state.resume.value != null
              ? [
                  ResumeModel(
                    downloadURL: state.resume.value!.path,
                    name: state.resume.value!.name,
                    ref: state.resume.value!.path,
                  ),
                ]
              : null,
          noResume: state.noResume,
          phoneNumber: state.phoneNumber.value!,
        ),
      );
      result.fold(
        (l) => emit(
          state.copyWith(
            failure: l.toEmployeeRespond(),
            formState: EmployeeRespondEnum.invalidData,
          ),
        ),
        (r) => emit(
          state.copyWith(
            formState: EmployeeRespondEnum.success,
            failure: EmployeeRespondFailure.none,
          ),
        ),
      );
    } else {
      emit(state.copyWith(formState: EmployeeRespondEnum.invalidData));
    }
  }

  void _onNoResumeChanged(
    _NoResumeChanged event,
    Emitter<EmployeeRespondState> emit,
  ) {
    emit(
      state.copyWith(
        noResume: !state.noResume,
        formState: EmployeeRespondEnum.initial,
      ),
    );
  }

  Future<void> _onLoadResumeClicked(
    _LoadResumeClicked event,
    Emitter<EmployeeRespondState> emit,
  ) async {
    final resumeFieldModel = ResumeFieldModel.dirty(
      await filePicker.pickMedia(),
    );
    if (resumeFieldModel.value == null) return;
    emit(
      state.copyWith(
        resume: resumeFieldModel,
        formState: EmployeeRespondEnum.initial,
      ),
    );
  }
}
