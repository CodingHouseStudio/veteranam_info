import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class FilterPopupMenuWidget extends StatelessWidget {
  const FilterPopupMenuWidget({required this.onResetValue, super.key});
  final void Function() onResetValue;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      key: KWidgetkeys.widget.filterPopupMenu.widget,
      icon: KIcon.filter,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            key: KWidgetkeys.widget.filterPopupMenu.resetAll,
            value: context.l10n.resetAllFilter,
            child: ListTile(
              title: Text(context.l10n.resetAllFilter),
            ),
          ),
        ];
      },
      onSelected: (dynamic selectedValue) {
        if (selectedValue == context.l10n.resetAllFilter) {
          onResetValue();
        }
      },
    );
  }
}
