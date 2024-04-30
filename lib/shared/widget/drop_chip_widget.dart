import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class DropChipWidget extends StatelessWidget {
  const DropChipWidget({
    required this.filters,
    required this.selectFilter,
    required this.onSelected,
    required this.isDesk,
    super.key,
  });
  final List<String> filters;
  final String? selectFilter;
  final void Function(String? newValue) onSelected;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: KWidgetTheme.boxDecorationWidget(context),
      child: DropdownButton<String?>(
        key: KWidgetkeys.widget.dropChip.widget,
        // focusColor: AppColors.transparent,
        isDense: true,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: KPadding.kPaddingSize24,
          vertical: KPadding.kPaddingSize8,
        ),
        underline: const SizedBox.shrink(),
        style: AppTextStyle.text20,
        value: selectFilter,
        onChanged: onSelected,
        items: filters
            .map<DropdownMenuItem<String?>>(
              (String? value) => DropdownMenuItem<String?>(
                key: KWidgetkeys.widget.dropChip.button,
                value: value,
                child: Text(value.toString()),
              ),
            )
            .toList(),
      ),
    );
  }
}
