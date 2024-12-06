import 'package:veteranam/shared/models/helper_models/translate_model.dart';

class FilterItem {
  const FilterItem(
    this.value, {
    this.number = 1,
    this.isSelected = false,
  });

  final TranslateModel value;
  final bool isSelected;
  final int number;

  FilterItem copyWith({
    TranslateModel? value,
    bool? isSelected,
    int? number,
  }) {
    return FilterItem(
      value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
      number: number ?? this.number,
    );
  }
}
