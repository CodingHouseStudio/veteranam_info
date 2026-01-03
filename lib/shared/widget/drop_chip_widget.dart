import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DropChipWidget extends StatelessWidget {
  const DropChipWidget({
    required this.filters,
    required this.selectFilter,
    required this.onSelected,
    required this.isDesk,
    super.key,
    this.widgetKey,
    this.buttonKey,
  });
  final List<String> filters;
  final String? selectFilter;
  final void Function(String? newValue) onSelected;
  final bool isDesk;
  final Key? widgetKey;
  final Key? buttonKey;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: KWidgetTheme.boxDecorationWidget,
      child: DropdownButton<String?>(
        key: widgetKey ?? DropChipKeys.widget,
        // focusColor: AppColors.transparent,
        isDense: true,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: KPadding.kPaddingSize24,
          vertical: KPadding.kPaddingSize8,
        ),
        underline: const SizedBox.shrink(),
        style: isDesk ? AppTextStyle.text20 : AppTextStyle.text16,
        value: selectFilter,
        onChanged: onSelected,
        items: filters
            .map<DropdownMenuItem<String?>>(
              (String? value) => DropdownMenuItem<String?>(
                key: buttonKey ?? DropChipKeys.buttons,
                value: value,
                child: Text(value.toString()),
              ),
            )
            .toList(),
      ),
    );
  }
}
