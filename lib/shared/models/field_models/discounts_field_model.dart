import 'package:formz/formz.dart';

enum DiscountsFieldModelValidationError { empty, wrongFormat }

class DiscountsFieldModel
    extends FormzInput<List<String>?, DiscountsFieldModelValidationError> {
  const DiscountsFieldModel.pure() : super.pure(null);

  const DiscountsFieldModel.dirty([super.value]) : super.dirty();

  DiscountsFieldModel addValue(String discount) {
    if (value == null) {
      return DiscountsFieldModel.dirty([discount]);
    } else {
      value!.add(discount);
      return this;
    }
  }

  List<int> get getValue {
    return value!
        .map(
          (discount) {
            if (discount.toLowerCase() == 'бескоштовно') {
              return 100;
            } else {
              return int.tryParse(discount);
            }
          },
        )
        .where((discount) => discount != null)
        .cast<int>()
        .toList();
  }

  @override
  DiscountsFieldModelValidationError? validator(List<String>? value) {
    if (value == null ||
        value.isEmpty ||
        value.every(
          (element) => element.isEmpty,
        )) {
      return DiscountsFieldModelValidationError.empty;
    }
    if (getValue.isEmpty) {
      return DiscountsFieldModelValidationError.wrongFormat;
    }
    return null;
  }
}
