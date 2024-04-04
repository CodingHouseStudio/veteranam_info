import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class DropChipWidget extends StatelessWidget {
  const DropChipWidget({required this.filters, super.key});
  final List<String> filters;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: KWidetTheme.boxDecorationWidget,
      // It's temporary widget for this design. While we have Wrap
      // IntrinsicWidth
      child: IntrinsicWidth(
        child: DropdownButton<dynamic>(
          key: KWidgetkeys.widget.dropChip.widget,
          isExpanded: true,
          focusColor: AppColors.transparent,
          isDense: true,
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: KPadding.kPaddingSize24,
            vertical: KPadding.kPaddingSize8,
          ),
          underline: const SizedBox.shrink(),
          style: AppTextStyle.text20,
          value: context.read<FilterCubit>().state.isNotEmpty &&
                  context.read<FilterCubit>().state.length - 1 >=
                      1 //(index + initialIndex)
                  &&
                  context
                      .read<FilterCubit>()
                      .state
                      .elementAt(1) //(index + initialIndex)
                      .toString()
                      .isNotEmpty
              ? context
                  .read<FilterCubit>()
                  .state
                  .elementAt(1) //(index + initialIndex)
                  .toString()
              : null,
          onChanged: (dynamic newValue) {
            context.read<FilterCubit>().change(
                  filterValue: newValue,
                  index: 1, //index + initialIndex,
                );
          },
          items: filters
              .map<DropdownMenuItem<dynamic>>(
                (dynamic value) => DropdownMenuItem<dynamic>(
                  key: KWidgetkeys.widget.dropChip.button,
                  value: value,
                  child: Text(value.toString()),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
