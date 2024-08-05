import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

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
            failure: null,
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
  @visibleForTesting
  static ImagePicker filePickerValue = ImagePicker();

  void _onEmailUpdated(
    _EmailUpdated event,
    Emitter<EmployeeRespondState> emit,
  ) {
    final emailFieldModel = EmailFieldModel.dirty(event.email);
    emit(
      state.copyWith(
        email: emailFieldModel,
        formState: EmployeeRespondEnum.inProgress,
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
        formState: EmployeeRespondEnum.inProgress,
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
        ) &&
        (state.noResume || state.resume.isValid)) {
      final result = await _employeeRespondRepository.sendRespond(
        EmployeeRespondModel(
          id: ExtendedDateTime.id,
          email: state.email.value,
          resume: state.noResume
              ? null
              : ResumeModel(
                  downloadURL: state.resume.value!.path,
                  name: state.resume.value!.name,
                  ref: state.resume.value!.path,
                ),
          noResume: state.noResume,
          phoneNumber: state.phoneNumber.value,
        ),
      );
      result.fold(
        (l) => emit(
          state.copyWith(
            failure: l.toEmployeeRespond(),
          ),
        ),
        (r) => emit(
          const EmployeeRespondState(
            formState: EmployeeRespondEnum.success,
            failure: null,
            email: EmailFieldModel.pure(),
            noResume: false,
            phoneNumber: PhoneNumberFieldModel.pure(),
            resume: ResumeFieldModel.pure(),
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
        formState: EmployeeRespondEnum.inProgress,
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
        formState: EmployeeRespondEnum.inProgress,
      ),
    );
  }
}
