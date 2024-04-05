import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class FilterPopupMenu extends StatelessWidget {
  const FilterPopupMenu({super.key});

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
          context.read<FilterCubit>().resetAllValues();
        }
      },
    );
  }
}
