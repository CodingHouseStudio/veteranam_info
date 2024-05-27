import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class FilterBoxWidget extends StatelessWidget {
  const FilterBoxWidget({
    required this.filters,
    super.key,
  });

  final List<String> filters;

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
          BlocBuilder<FilterCubit, List<dynamic>>(
            builder: (context, state) {
              return Wrap(
                children: _buildChips(context),
              );
            },
          ),
        if (KPlatformConstants.isWebMobile)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: BlocBuilder<FilterCubit, List<dynamic>>(
              builder: (context, state) {
                return Row(
                  children: _buildChips(context),
                );
              },
            ),
          ),
      ],
    );
  }

  List<Widget> _buildChips(BuildContext context) {
    return filters.map((filter) {
      return Padding(
        padding: const EdgeInsets.only(
          right: KPadding.kPaddingSize20,
          bottom: KPadding.kPaddingSize10,
        ),
        child: filters.first == filter
            ? DropChipWidget(
                filters: filters,
                selectFilter: context.read<FilterCubit>().state.isNotEmpty &&
                        context.read<FilterCubit>().state.length - 1 >= 1 &&
                        context
                            .read<FilterCubit>()
                            .state
                            .elementAt(1)
                            .toString()
                            .isNotEmpty
                    ? context.read<FilterCubit>().state.elementAt(1).toString()
                    : null,
                isDesk: true,
                onSelected: (newValue) => context.read<FilterCubit>().change(
                      filterValue: newValue,
                      index: 1,
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
