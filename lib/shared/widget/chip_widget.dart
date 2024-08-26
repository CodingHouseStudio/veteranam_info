import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

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
        filter: filter,
        isSelected: isSelected,
        onSelected: onSelected,
      );
    } else {
      return _ChipMobWidget(
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
    super.key,
  });
  final FilterItem filter;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;

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
      child: FilterChip(
        key: KWidgetkeys.widget.chip.desk,
        backgroundColor: AppColors.materialThemeWhite,
        labelPadding: EdgeInsets.zero,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: widget.isSelected
                    ? KPadding.kPaddingSize8
                    : KPadding.kPaddingSize10,
                right: KPadding.kPaddingSize10,
              ),
              child: Text(
                widget.filter.getString(context),
                key: KWidgetkeys.widget.chip.text,
                style: AppTextStyle.materialThemeHeadlineSmall.copyWith(
                  color: _isHovered && !widget.isSelected && !filterEmpty
                      ? AppColors.materialThemeKeyColorsNeutralVariant
                      : AppColors.materialThemeBlack,
                ),
              ),
            ),
            if (!filterEmpty)
              AmountWidget(
                key: KWidgetkeys.widget.chip.amount,
                background: widget.isSelected
                    ? AppColors.materialThemeBlack
                    : AppColors.materialThemeKeyColorsPrimary,
                textColor: widget.isSelected
                    ? AppColors.materialThemeWhite
                    : (!widget.isSelected && _isHovered
                        ? AppColors.materialThemeKeyColorsNeutralVariant
                        : AppColors.materialThemeBlack),
                number: widget.filter.number,
              ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: KBorderRadius.kBorderRadius32,
        ),
        side: BorderSide(
          color: !widget.isSelected
              ? (_isHovered || filterEmpty
                  ? AppColors.materialThemeKeyColorsNeutralVariant
                  : AppColors.materialThemeBlack)
              : Colors.transparent,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        selected: widget.isSelected,
        onSelected: !filterEmpty ? widget.onSelected : null,
        checkmarkColor: AppColors.materialThemeRefSecondarySecondary10,
        selectedColor: _isHovered
            ? AppColors.materialThemeRefPrimaryPrimary90
            : AppColors.materialThemeSourceSeed,
      ),
    );
  }
}

class _ChipMobWidget extends StatelessWidget {
  const _ChipMobWidget({
    required this.filter,
    required this.isSelected,
    this.onSelected,
  });
  final FilterItem filter;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;

  @override
  Widget build(BuildContext context) {
    final filterEmpty = filter.number == 0 && !isSelected;
    return MouseRegion(
      child: FilterChip(
        key: KWidgetkeys.widget.chip.mob,
        backgroundColor: AppColors.materialThemeWhite,
        labelPadding: EdgeInsets.zero,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: isSelected
                    ? KPadding.kPaddingSize8
                    : KPadding.kPaddingSize10,
                right: KPadding.kPaddingSize10,
              ),
              child: Text(
                filter.getString(context),
                key: KWidgetkeys.widget.chip.text,
                style: AppTextStyle.materialThemeLabelLarge.copyWith(
                  color: AppColors.materialThemeBlack,
                ),
              ),
            ),
            if (!filterEmpty)
              AmountWidget(
                key: KWidgetkeys.widget.chip.amount,
                background: isSelected
                    ? AppColors.materialThemeBlack
                    : AppColors.materialThemeKeyColorsPrimary,
                textColor: isSelected
                    ? AppColors.materialThemeWhite
                    : AppColors.materialThemeBlack,
                number: filter.number,
              ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: KBorderRadius.kBorderRadius32,
        ),
        side: BorderSide(
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
        selectedColor: AppColors.materialThemeSourceSeed,
      ),
    );
  }
}
