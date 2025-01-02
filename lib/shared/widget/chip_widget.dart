import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({
    required this.filter,
    required this.isSelected,
    required this.onSelected,
    required this.isDesk,
    super.key,
  });
  final FilterItem filter;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return ChipDeskWidget(
        widgetKey: KWidgetkeys.widget.chip.desk,
        filter: filter,
        isSelected: isSelected,
        onSelected: onSelected,
      );
    } else {
      return ChipImplementationWidget(
        widgetKey: KWidgetkeys.widget.chip.mob,
        filter: filter,
        isSelected: isSelected,
        onSelected: onSelected,
      );
    }
  }
}

class ChipDeskWidget extends StatefulWidget {
  const ChipDeskWidget({
    required this.filter,
    required this.isSelected,
    required this.onSelected,
    required this.widgetKey,
    super.key,
  });
  final FilterItem filter;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;
  final Key widgetKey;

  @override
  ChipDeskWidgetState createState() => ChipDeskWidgetState();
}

class ChipDeskWidgetState extends State<ChipDeskWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final filterEmpty = widget.filter.number == 0 && !widget.isSelected;
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
      },
      onExit: (_) {
        setState(() => _isHovered = false);
      },
      child: ChipImplementationWidget(
        key: ValueKey(widget.filter.value),
        filter: widget.filter,
        isSelected: widget.isSelected,
        amountTextColor: widget.isSelected
            ? AppColors.materialThemeWhite
            : (!widget.isSelected && _isHovered
                ? AppColors.materialThemeKeyColorsNeutralVariant
                : AppColors.materialThemeBlack),
        onSelected: widget.onSelected,
        selectedColor: _isHovered
            ? AppColors.materialThemeRefPrimaryPrimary90
            : AppColors.materialThemeSourceSeed,
        side: BorderSide(
          color: !widget.isSelected
              ? (_isHovered || filterEmpty
                  ? AppColors.materialThemeKeyColorsNeutralVariant
                  : AppColors.materialThemeBlack)
              : Colors.transparent,
        ),
        textStyle: _isHovered && !widget.isSelected && !filterEmpty
            ? AppTextStyle.materialThemeHeadlineSmallVariant
            : AppTextStyle.materialThemeHeadlineSmall,
        widgetKey: widget.widgetKey,
      ),
    );
  }
}

class ChipImplementationWidget extends StatelessWidget {
  const ChipImplementationWidget({
    required this.filter,
    required this.isSelected,
    required this.widgetKey,
    super.key,
    this.onSelected,
    this.textStyle,
    this.amountTextColor,
    this.side,
    this.selectedColor,
  });
  final FilterItem filter;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;
  final TextStyle? textStyle;
  final Color? amountTextColor;
  final BorderSide? side;
  final Color? selectedColor;
  final Key widgetKey;

  @override
  Widget build(BuildContext context) {
    final filterEmpty = filter.number == 0 && !isSelected;
    return FilterChip(
      key: widgetKey,
      backgroundColor: AppColors.materialThemeWhite,
      labelPadding: EdgeInsets.zero,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: KPadding.kPaddingSize10,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left:
                  isSelected ? KPadding.kPaddingSize8 : KPadding.kPaddingSize10,
            ),
            child: Text(
              filter.value.getTrsnslation(context),
              key: KWidgetkeys.widget.chip.text,
              style: textStyle ?? AppTextStyle.materialThemeLabelLarge,
            ),
          ),
          if (!filterEmpty)
            AmountWidget(
              key: KWidgetkeys.widget.chip.amount,
              background: isSelected
                  ? AppColors.materialThemeBlack
                  : AppColors.materialThemeKeyColorsPrimary,
              textColor: amountTextColor ??
                  (isSelected
                      ? AppColors.materialThemeWhite
                      : AppColors.materialThemeBlack),
              number: filter.number,
            ),
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
      side: side ??
          BorderSide(
            color: !isSelected
                ? (filterEmpty
                    ? AppColors.materialThemeKeyColorsNeutralVariant
                    : AppColors.materialThemeBlack)
                : Colors.transparent,
          ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      selected: isSelected,
      onSelected: !filterEmpty ? onSelected : null,
      checkmarkColor: AppColors.materialThemeRefSecondarySecondary10,
      selectedColor: selectedColor ?? AppColors.materialThemeSourceSeed,
    );
  }
}
