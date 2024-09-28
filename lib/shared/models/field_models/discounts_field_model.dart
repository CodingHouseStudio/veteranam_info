import 'package:formz/formz.dart';
import 'package:veteranam/shared/shared.dart';

enum DiscountsFieldModelValidationError { empty, wrongFormat }

class DiscountsFieldModel
    extends FormzInput<List<String>?, DiscountsFieldModelValidationError> {
  const DiscountsFieldModel.pure() : super.pure(null);

  const DiscountsFieldModel.dirty([super.value]) : super.dirty();

  DiscountsFieldModel add(String discount) {
    final discountValue = _getAddPercent(discount);
    return DiscountsFieldModel.dirty(value.addFieldModel(discountValue));
  }

  DiscountsFieldModel remove(String discount) {
    final discountValue = _getAddPercent(discount);
    return DiscountsFieldModel.dirty(value.removeFieldModel(discountValue));
  }

  String _getAddPercent(String value) {
    final intValue = int.tryParse(value);
    return intValue == null ? value : '$intValue%';
  }

  List<int?> get getValue {
    return value!.map(
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
    return null;
  }
}
