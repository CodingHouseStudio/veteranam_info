import 'package:formz/formz.dart';

enum DiscountsFieldModelValidationError {
  empty,
  wrongFormat,
  wrongRange,
}

class DiscountsFieldModel
    extends FormzInput<List<String>, DiscountsFieldModelValidationError> {
  const DiscountsFieldModel.pure() : super.pure(const []);

  const DiscountsFieldModel.dirty([super.value = const []]) : super.dirty();

  List<int?> get getValue {
    return value.map(
      (discount) {
        if (discount.toLowerCase() == 'безкоштовно' ||
            discount.toLowerCase() == 'free') {
          return 100;
        } else {
          return int.tryParse(discount.replaceAll('%', ''));
        }
      },
    ).toList();
  }

  @override
  DiscountsFieldModelValidationError? validator(List<String>? value) {
    if (value == null ||
        value.isEmpty ||
        value.any(
          (element) => element.trim().isEmpty,
        )) {
      return DiscountsFieldModelValidationError.empty;
    }
    final listValue = getValue;
    if (listValue.isEmpty ||
        listValue.any(
          (element) => element == null,
        )) {
      return DiscountsFieldModelValidationError.wrongFormat;
    }
    if (listValue.any(
      (element) => element == null || element > 100 || element < 1,
    )) {
      return DiscountsFieldModelValidationError.wrongRange;
    }
    return null;
  }
}
