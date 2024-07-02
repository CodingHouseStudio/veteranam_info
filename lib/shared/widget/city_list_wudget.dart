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
  bool isExpanded = false;
  @override
  void initState() {
    isExpanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isDesk ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: KPadding.kPaddingSize10,
            horizontal: KPadding.kPaddingSize16,
          ),
          decoration: KWidgetTheme.boxDecorationDiscountContainer,
          child: Wrap(
            children: [
              KIcon.distance,
              if (widget.discountModel.location?.isEmpty ?? true)
                Text(
                  widget.discountModel.subLocation.getList(context).first,
                  style: AppTextStyle.materialThemeLabelLarge,
                ),
              if (widget.discountModel.location?.isNotEmpty ?? false)
                Text(
                  widget.discountModel.location!.first +
                      (isExpanded ? ' | ' : ''),
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
                if (widget.isDesk)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: KPadding.kPaddingSize8,
                    ),
                    child: Text(
                      isExpanded
                          ? context.l10n.hideExpansion
                          : context.l10n.moreCities(
                              (widget.discountModel.location ?? []).length - 1,
                            ),
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
