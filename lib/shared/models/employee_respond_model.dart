import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/models/models.dart';

part 'employee_respond_model.freezed.dart';
part 'employee_respond_model.g.dart';

@freezed
abstract class EmployeeRespondModel with _$EmployeeRespondModel {
  const factory EmployeeRespondModel({
    required String id,
    required String email,
    required String phoneNumber,
    required bool noResume,
    @ResumeConverter() ResumeModel? resume,
  }) = _EmployeeRespondModel;

  factory EmployeeRespondModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeRespondModelFromJson(json);
}

abstract class EmployeeRespondModelJsonField {
  static const id = 'id';
  static const email = 'email';
  static const phoneNumber = 'phoneNumber';
  static const noResume = 'noResume';
  static const resume = 'resume';
}
