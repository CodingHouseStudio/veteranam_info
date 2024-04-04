import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class DropChip extends StatelessWidget {
  const DropChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<dynamic>(
      isDense: true,
      style: AppTextStyle.m3LabelMedium,
      value: context.read<FilterCubit>().state.isNotEmpty &&
              context.read<FilterCubit>().state.length - 1 >=
                  (index + initialIndex) &&
              context
                  .read<FilterCubit>()
                  .state
                  .elementAt(index + initialIndex)
                  .toString()
                  .isNotEmpty
          ? context
              .read<FilterCubit>()
              .state
              .elementAt(index + initialIndex)
              .toString()
          : DropdownButtonVariables.filterStandartValue,
      onChanged: (dynamic newValue) {
        context.read<FilterCubit>().change(
              filterValue: newValue,
              index: index + initialIndex,
            );
        // changeFiltersFunction?.call(
        //   newValue: newValue,
        //   index: index + initialIndex,
        // );
      },
      items: filters
          .map<DropdownMenuItem<dynamic>>(
            (dynamic value) => DropdownMenuItem<dynamic>(
              value: value,
              child: Text(value.toString()),
            ),
          )
          .toList(),
    );
  }
}
