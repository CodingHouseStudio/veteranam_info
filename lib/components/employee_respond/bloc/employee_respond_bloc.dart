import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/models/employee_respond_model.dart';
import 'package:kozak/shared/models/field_models/phone_field_model.dart';
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
            resume: null,
            noResume: false,
            formState: EmployeeRespondEnum.initial,
            failure: EmployeeRespondFailure.initial,
          ),
        ) {
    on<_EmailUpdated>(_onEmailUpdated);
    on<_PhoneUpdated>(_onPhoneUpdated);
    on<_Save>(_onSave);
  }

  final IWorkRepository _employeeRespondRepository;

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
    final phoneFieldModel = PhoneNumberFieldModel.dirty(event.phone.toString());
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
          resume: null,
          noResume: false,
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
          const EmployeeRespondState(
            email: EmailFieldModel.pure(),
            phoneNumber: PhoneNumberFieldModel.pure(),
            resume: null,
            noResume: false,
            formState: EmployeeRespondEnum.success,
            failure: EmployeeRespondFailure.none,
          ),
        ),
      );
    }
  }
}
