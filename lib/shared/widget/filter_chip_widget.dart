import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class FiltersChipWidget extends StatefulWidget {
  const FiltersChipWidget({
    required this.filtersItems,
    required this.isDesk,
    required this.onResetValue,
    required this.onSelected,
    required this.isSelected,
    super.key,
  });

  final List<String> filtersItems;
  final bool isDesk;
  final void Function() onResetValue;
  final void Function(
    int index,
  ) onSelected;
  final bool Function(
    int index,
  ) isSelected;

  @override
  FiltersChipWidgetState createState() => FiltersChipWidgetState();
}

class FiltersChipWidgetState extends State<FiltersChipWidget> {
  int? selectedFilterIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: KWidgetkeys.widget.filterChip.widget,
      children: [
        TextButton.icon(
          icon: selectedFilterIndex == null ? KIcon.check : null,
          key: KWidgetkeys.widget.filterPopupMenu.resetAll,
          onPressed: () {
            selectedFilterIndex = null;
            widget.onResetValue();
          },
          style: selectedFilterIndex == null
              ? KButtonStyles.filterButtonStyleBorder
              : KButtonStyles.filterButtonStyleBorderWhite,
          label: Text(
            context.l10n.all,
            style: widget.isDesk
                ? AppTextStyle.filterText20
                : AppTextStyle.filterText16,
          ),
        ),
        // FilterPopupMenuWidget(
        //   key: KWidgetkeys.widget.filterChip.popup,
        //   onResetValue: onResetValue,
        //   isDesk: isDesk,
        // ),
        KSizedBox.kWidthSizedBox24,
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(widget.filtersItems.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: widget.isDesk
                        ? KPadding.kPaddingSize16
                        : KPadding.kPaddingSize8,
                  ),
                  child: ChipWidget(
                    key: KWidgetkeys.widget.filterChip.chips,
                    filter: widget.filtersItems.elementAt(index),
                    onSelected: ({required isSelected}) {
                      selectedFilterIndex = index;
                      widget.onSelected(
                        index,
                      );
                    },
                    isSelected: widget.isSelected(
                      index,
                    ),
                    isDesk: widget.isDesk,
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
