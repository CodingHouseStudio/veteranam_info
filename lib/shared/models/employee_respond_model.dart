import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kozak/shared/shared.dart';

part 'employee_respond_model.freezed.dart';
part 'employee_respond_model.g.dart';

@freezed
class EmployeeRespondModel with _$EmployeeRespondModel {
  const factory EmployeeRespondModel({
    required String id,
    required String email,
    required String phoneNumber,
    required bool noResume,
    @ResumeConverter() List<ResumeModel>? resume,
  }) = _EmployeeRespondModel;

  factory EmployeeRespondModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeRespondModelFromJson(json);
}
