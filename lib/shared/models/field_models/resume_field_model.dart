import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:kozak/shared/shared.dart';

enum ResumeFieldModelValidationError { empty }

extension ResumeFieldModelValidationErrorEmpl
    on ResumeFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case ResumeFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case null:
        return null;
    }
  }
}

class ResumeFieldModel
    extends FormzInput<String?, ResumeFieldModelValidationError> {
  const ResumeFieldModel.dirty(
    super.value, {
    this.isCheckboxChecked = false,
  }) : super.dirty();

  const ResumeFieldModel.pure({this.isCheckboxChecked = false})
      : super.pure(null);
  final bool isCheckboxChecked;

  @override
  ResumeFieldModelValidationError? validator(String? value) {
    if (isCheckboxChecked) {
      return null;
    }
    if (value == null || value.isEmpty) {
      return ResumeFieldModelValidationError.empty;
    }
    return null;
  }
}
