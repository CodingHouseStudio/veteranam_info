import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ChipWidget extends StatefulWidget {
  const ChipWidget({
    required this.filter,
    required this.isSelected,
    required this.onSelected,
    required this.isDesk,
    required this.itemCount,
    super.key,
  });
  final String filter;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;
  final bool isDesk;
  final int itemCount;

  @override
  ChipWidgetState createState() => ChipWidgetState();
}

class ChipWidgetState extends State<ChipWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: FilterChip(
        key: KWidgetkeys.widget.chip.widget,
        backgroundColor: AppColors.materialThemeWhite,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.filter,
              style: (widget.isDesk
                      ? AppTextStyle.materialThemeHeadlineSmall
                      : AppTextStyle.materialThemeLabelLarge)
                  .copyWith(
                color: _isHovered && !widget.isSelected && widget.itemCount > 0
                    ? AppColors.materialThemeKeyColorsNeutralVariant
                    : AppColors.materialThemeBlack,
              ),
            ),
            KSizedBox.kWidthSizedBox10,
            if (widget.itemCount > 0)
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(KPadding.kPaddingSize8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.isSelected
                          ? AppColors.materialThemeBlack
                          : AppColors.materialThemeKeyColorsPrimary,
                    ),
                    child: Text(
                      '${widget.itemCount}',
                      style: AppTextStyle.materialThemeLabelSmall.copyWith(
                        color: widget.isSelected
                            ? AppColors.materialThemeWhite
                            : (!widget.isSelected && _isHovered
                                ? AppColors.materialThemeKeyColorsNeutralVariant
                                : AppColors.materialThemeBlack),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: KBorderRadius.kBorderRadius32,
        ),
        side: BorderSide(
          color: !widget.isSelected
              ? (_isHovered || widget.itemCount == 0
                  ? AppColors.materialThemeKeyColorsNeutralVariant
                  : AppColors.materialThemeBlack)
              : Colors.transparent,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        selected: widget.isSelected,
        onSelected: widget.itemCount > 0 ? widget.onSelected : null,
        checkmarkColor: AppColors.materialThemeRefSecondarySecondary10,
        selectedColor: _isHovered
            ? AppColors.materialThemeRefPrimaryPrimary90
            : AppColors.materialThemeSourceSeed,
      ),
    );
  }
}
