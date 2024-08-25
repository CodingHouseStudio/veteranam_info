import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class ChipWidget extends StatefulWidget {
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
  ChipWidgetState createState() => ChipWidgetState();
}

class ChipWidgetState extends State<ChipWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final filterEmpty = widget.filter.number == 0 && !widget.isSelected;
    return MouseRegion(
      // coverage:ignore-start
      onEnter: (_) {
        setState(() => _isHovered = true);
      },
      onExit: (_) {
        setState(() => _isHovered = false);
      },
      // coverage:ignore-end
      child: FilterChip(
        key: KWidgetkeys.widget.chip.widget,
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
                style: (widget.isDesk
                        ? AppTextStyle.materialThemeHeadlineSmall
                        : AppTextStyle.materialThemeLabelLarge)
                    .copyWith(
                  color: _isHovered && !widget.isSelected && !filterEmpty
                      ? AppColors.materialThemeKeyColorsNeutralVariant
                      : AppColors.materialThemeBlack,
                ),
              ),
            ),
            if (!filterEmpty)
              AmountWidget(
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
