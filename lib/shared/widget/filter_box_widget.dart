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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PopupMenuButton<String>(
          key: KWidgetkeys.filterKeys.popupMenu,
          icon: KIcon.filter,
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                key: KWidgetkeys.filterKeys.popupMenuResetAll,
                value: KAppText.filterItemResetAll,
                child: const ListTile(
                  title: Text(KAppText.filterItemResetAll),
                ),
              ),
            ];
          },
          onSelected: (dynamic selectedValue) {
            if (selectedValue == KAppText.filterItemResetAll) {
              context.read<FilterCubit>().resetAllValues();
            }
          },
        ),
        KSizedBox.kWidthSizedBoxS,
        if (!PlatformConstants.isWebMobile)
          Expanded(
            child: Wrap(
              key: KWidgetkeys.filterKeys.chips,
              children: _buildChips(),
            ),
          ),
        if (PlatformConstants.isWebMobile)
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                key: KWidgetkeys.filterKeys.chips,
                children: _buildChips(),
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
          right: KPadding.kPaddingSizeM,
          bottom: KPadding.kPaddingSizeS,
        ),
        child: BlocBuilder<FilterCubit, List<dynamic>>(
          builder: (context, state) {
            return FilterChip(
              key: widget.filters.last == filter
                  ? KWidgetkeys.filterKeys.lastChip
                  : null,
              label: Text(
                filter,
                style: AppTextStyle.lableMediumSmall,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: KBorderRadius.kBorderRadiusM,
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: context.read<FilterCubit>().state.isNotEmpty &&
                  context
                      .read<FilterCubit>()
                      .state
                      .elementAt(0)
                      .toString()
                      .contains(filter),
              onSelected: (bool isSelected) =>
                  context.read<FilterCubit>().change(
                        filterValue: filter,
                        index: 0,
                      ),
            );
          },
        ),
      );
    }).toList();
  }
}
