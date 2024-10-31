import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FilterPopupMenuWidget extends StatelessWidget {
  const FilterPopupMenuWidget({
    required this.onResetValue,
    required this.isDesk,
    super.key,
  });
  final void Function() onResetValue;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      key: KWidgetkeys.widget.filterPopupMenu.widget,
      icon: KIcon.filter,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            key: KWidgetkeys.widget.filterPopupMenu.resetAll,
            value: context.l10n.resetAll,
            child: ListTile(
              title: Text(
                context.l10n.resetAll,
                style: isDesk ? AppTextStyle.text20 : AppTextStyle.text16,
              ),
            ),
          ),
        ];
      },
      onSelected: (dynamic selectedValue) {
        if (selectedValue == context.l10n.resetAll) {
          onResetValue();
        }
      },
    );
  }
}
