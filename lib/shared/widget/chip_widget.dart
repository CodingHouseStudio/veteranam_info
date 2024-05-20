import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({
    required this.filter,
    required this.isSelected,
    required this.onSelected,
    required this.isDesk,
    super.key,
  });
  final String filter;
  final bool isSelected;
  final void Function({required bool isSelected}) onSelected;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      key: KWidgetkeys.widget.chip.widget,
      backgroundColor: context.color.background,
      label: Text(
        filter,
        style: isDesk ? AppTextStyle.text20 : AppTextStyle.text16,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      selected: isSelected,
      onSelected: (value) => onSelected(isSelected: value),
      // checkmarkColor: AppColors.black,
      selectedColor: context.color.secondary,
    );
  }
}
