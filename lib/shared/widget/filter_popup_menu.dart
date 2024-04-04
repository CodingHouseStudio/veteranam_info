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
    );
  }
}
