import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class CustomSwitcherWidget<T> extends StatelessWidget {
  const CustomSwitcherWidget({
    required this.values,
    required this.getText,
    required this.isCheck,
    required this.onSwitch,
    super.key,
    this.decoration,
  });

  final Decoration? decoration;
  final List<T> values;
  final String Function(T value) getText;
  final bool Function(T value) isCheck;
  final void Function()? onSwitch;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: KWidgetkeys.widget.customSwitcher.widget,
      style: KButtonStyles.withoutStyle,
      onPressed: onSwitch,
      icon: DecoratedBox(
        decoration: decoration ?? KWidgetTheme.boxDecorationWhiteMain,
        child: Row(
          key: KWidgetkeys.widget.customSwitcher.item,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            values.length,
            (index) => Padding(
              padding: index == 0
                  ? EdgeInsets.zero
                  : const EdgeInsets.only(left: KPadding.kPaddingSize8),
              child: _buildLanguageOption(
                getText(values.elementAt(index)),
                isCheck(values.elementAt(index)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    String languageName,
    bool isSelected,
  ) {
    return Container(
      decoration: isSelected
          ? KWidgetTheme.boxDecorationBlackCircular
          : KWidgetTheme.boxDecorationGrayCircular,
      margin: const EdgeInsets.symmetric(vertical: KPadding.kPaddingSize2),
      padding: const EdgeInsets.symmetric(
        horizontal: KPadding.kPaddingSize12,
        vertical: KPadding.kPaddingSize8,
      ),
      child: Text(
        languageName,
        key: KWidgetkeys.widget.customSwitcher.text,
        style: isSelected
            ? AppTextStyle.materialThemeTitleMediumNeutral
            : AppTextStyle.materialThemeTitleMedium,
      ),
    );
  }
}
