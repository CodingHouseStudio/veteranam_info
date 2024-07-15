import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class CityWidgetList extends StatefulWidget {
  const CityWidgetList({
    required this.discountModel,
    required this.isDesk,
    super.key,
  });

  final DiscountModel discountModel;
  final bool isDesk;

  @override
  State<CityWidgetList> createState() => _CityWidgetListState();
}

class _CityWidgetListState extends State<CityWidgetList> {
  String? get cityList {
    String? cityText = widget.discountModel.location!.first;
    if ((widget.discountModel.location ?? []).length > 1) {
      isExpanded ? cityText += ' | ' : cityText += '';
    }
    return cityText;
  }

  bool isExpanded = false;
  bool isHovered = false;
  @override
  void initState() {
    isExpanded = false;
    isHovered = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isDesk ? Alignment.centerRight : Alignment.centerLeft,
      child: TextButton.icon(
        style: (widget.discountModel.location ?? []).length == 1
            ? KButtonStyles.discountCityButtonStyle.copyWith(
                mouseCursor:
                    const WidgetStatePropertyAll(MouseCursor.uncontrolled),
              )
            : KButtonStyles.discountCityButtonStyle,
        onPressed: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        icon: KIcon.distance,
        label: Padding(
          padding: EdgeInsets.symmetric(
            vertical: widget.isDesk
                ? KPadding.kPaddingSize10
                : KPadding.kPaddingSize6_5,
          ),
          child: Wrap(
            children: [
              if (widget.discountModel.location?.isEmpty ?? true)
                Text(
                  widget.discountModel.subLocation.getList(context).first,
                  style: AppTextStyle.materialThemeLabelLarge,
                )
              else
                Text(
                  cityList!,
                  style: AppTextStyle.materialThemeLabelLarge,
                ),
              if (isExpanded)
                ...(widget.discountModel.location?.skip(1) ?? []).map(
                  (location) => Text(
                    '$location | ',
                    style: AppTextStyle.materialThemeLabelLarge,
                  ),
                ),
              if ((widget.discountModel.location ?? []).length > 1)
                //if (widget.isDesk)
                Padding(
                  padding: const EdgeInsets.only(
                    left: KPadding.kPaddingSize8,
                  ),
                  child: Text(
                    isExpanded
                        ? widget.isDesk
                            ? context.l10n.hideExpansion
                            : ''
                        : widget.isDesk
                            ? context.l10n.moreCities(
                                (widget.discountModel.location ?? []).length -
                                    1,
                              )
                            : '...',
                    style: AppTextStyle.materialThemeLabelLarge.copyWith(
                      decoration: TextDecoration.underline,
                      color: AppColors.materialThemeRefTertiaryTertiary40,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
