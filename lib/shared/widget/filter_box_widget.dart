import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class FilterBoxWidget extends StatefulWidget {
  const FilterBoxWidget({
    required this.filters,
    // required this.index,
    super.key,
  });
  final List<String> filters;
  // final int index;

  @override
  State<FilterBoxWidget> createState() => _FilterBoxWidgetState();
}

class _FilterBoxWidgetState extends State<FilterBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      key: KWidgetkeys.widget.filter.widget,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterPopupMenuWidget(
          onResetValue: () => context.read<FilterCubit>().resetAllValues(),
        ),
        KSizedBox.kWidthSizedBox10,
        if (!KPlatformConstants.isWebMobile)
          Expanded(
            child: BlocBuilder<FilterCubit, List<dynamic>>(
              builder: (context, state) {
                return Wrap(
                  children: _buildChips(),
                );
              },
            ),
          ),
        if (KPlatformConstants.isWebMobile)
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: BlocBuilder<FilterCubit, List<dynamic>>(
                builder: (context, state) {
                  return Row(
                    children: _buildChips(),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  List<Widget> _buildChips() {
    return widget.filters.map((filter) {
      return Padding(
        padding: const EdgeInsets.only(
          right: KPadding.kPaddingSize20,
          bottom: KPadding.kPaddingSize10,
        ),
        child: widget.filters.first == filter
            ? DropChipWidget(
                filters: widget.filters,
                selectFilter: context.read<FilterCubit>().state.isNotEmpty &&
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
                isDesk: true,
                onSelected: (newValue) => context.read<FilterCubit>().change(
                      filterValue: newValue,
                      index: 1, //index + initialIndex,
                    ),
              )
            : ChipWidget(
                filter: filter,
                isSelected: context.read<FilterCubit>().state.isNotEmpty &&
                    context
                        .read<FilterCubit>()
                        .state
                        .elementAt(0)
                        .toString()
                        .contains(filter),
                onSelected: ({required bool isSelected}) =>
                    context.read<FilterCubit>().change(
                          filterValue: filter,
                          index: 0,
                        ),
                isDesk: true,
              ),
      );
    }).toList();
  }
}
