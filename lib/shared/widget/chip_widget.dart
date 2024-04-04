import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({required this.filter, super.key, this.filterKey});
  final String filter;
  final Key? filterKey;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      key: filterKey,
      label: Text(
        filter,
        style: AppTextStyle.text18,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      selected: context.read<FilterCubit>().state.isNotEmpty &&
          context
              .read<FilterCubit>()
              .state
              .elementAt(0)
              .toString()
              .contains(filter),
      onSelected: (bool isSelected) => context.read<FilterCubit>().change(
            filterValue: filter,
            index: 0,
          ),
      checkmarkColor: AppColors.black,
      selectedColor: AppColors.widgetBackground,
    );
  }
}
