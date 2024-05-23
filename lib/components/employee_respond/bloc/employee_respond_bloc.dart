import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kozak/shared/shared.dart';

part 'employee_respond_event.dart';
part 'employee_respond_state.dart';
part 'employee_respond_bloc.freezed.dart';

class EmployeeRespondBloc
    extends Bloc<EmployeeRespondEvent, EmployeeRespondState> {
  EmployeeRespondBloc() : super(const _Initial()) {
    on<EmployeeRespondEvent>((event, emit) {});
  }
}
