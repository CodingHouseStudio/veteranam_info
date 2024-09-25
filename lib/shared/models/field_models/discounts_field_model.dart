import 'package:formz/formz.dart';

enum DiscountsFieldModelValidationError { empty, wrongFormat }

class DiscountsFieldModel
    extends FormzInput<List<String>?, DiscountsFieldModelValidationError> {
  const DiscountsFieldModel.pure() : super.pure(null);

  const DiscountsFieldModel.dirty([super.value]) : super.dirty();

  DiscountsFieldModel add(String discount) {
    final discountValue = _addPercent(discount);
    if (value == null) {
      return DiscountsFieldModel.dirty([discountValue]);
    } else {
      late List<String> list;
      if (value!.contains(discountValue)) {
        list = value!;
      } else {
        list = List.from(value!)..add(discountValue);
      }
      return DiscountsFieldModel.dirty(list);
    }
  }

  DiscountsFieldModel remove(String discount) {
    final discountValue = _addPercent(discount);
    if (value == null) {
      return const DiscountsFieldModel.dirty([]);
    } else {
      return DiscountsFieldModel.dirty(
        List.from(value!)..remove(discountValue),
      );
    }
  }

  String _addPercent(String value) {
    final intValue = int.tryParse(value);
    return intValue == null ? value : '$intValue%';
  }

  List<int> get getValue {
    return value!
        .map(
          (discount) {
            if (discount.toLowerCase() == 'безкоштовно' ||
                discount.toLowerCase() == 'free') {
              return 100;
            } else {
              return int.tryParse(discount.replaceAll('%', ''));
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
