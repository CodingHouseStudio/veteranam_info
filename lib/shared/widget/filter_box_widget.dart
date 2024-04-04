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
          key: KWidgetkeys.widget.filter.popupMenu,
          icon: KIcon.filter,
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                key: KWidgetkeys.widget.filter.popupMenuResetAll,
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
        KSizedBox.kWidthSizedBox10,
        if (!KPlatformConstants.isWebMobile)
          Expanded(
            child: Wrap(
              key: KWidgetkeys.widget.filter.chips,
              children: _buildChips(),
            ),
          ),
        if (KPlatformConstants.isWebMobile)
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                key: KWidgetkeys.widget.filter.chips,
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
          right: KPadding.kPaddingSize20,
          bottom: KPadding.kPaddingSize10,
        ),
        child: ChipWidget(
          filterKey: widget.filters.last == filter
              ? KWidgetkeys.widget.filter.lastChip
              : null,
          filter: filter,
        ),
      );
    }).toList();
  }
}
