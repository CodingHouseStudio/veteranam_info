import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class FiltersChipWidget extends StatelessWidget {
  const FiltersChipWidget({
    required this.filtersItems,
    required this.isDesk,
    // required this.onResetValue,
    required this.onSelected,
    required this.isSelected,
    required this.fullLenght,
    required this.filterIsEmpty,
    super.key,
  });

  final List<FilterItem> filtersItems;
  final int fullLenght;
  final bool isDesk;
  final bool filterIsEmpty;
  // final void Function() onResetValue;
  final void Function(
    int index,
  ) onSelected;
  final bool Function(
    int index,
  ) isSelected;

  @override
  Widget build(BuildContext context) {
    // return Row(
    //   key: KWidgetkeys.widget.filterChip.widget,
    //   children: [
    //     FilterPopupMenuWidget(
    //       key: KWidgetkeys.widget.filterChip.popup,
    //       onResetValue: onResetValue,
    //       isDesk: isDesk,
    //     ),
    //     KSizedBox.kWidthSizedBox24,
    //     Expanded(
    //       child:
    return isDesk
        ? ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  AppColors.materialThemeWhite,
                  AppColors.materialThemeWhite.withOpacity(0.03),
                ],
                stops: const [0.8, 1],
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child: _body(context),
          )
        : _body(context);
    //     ),
    //   ],
    // );
  }

  Widget _body(BuildContext context) => SingleChildScrollView(
        key: KWidgetkeys.widget.filterChip.widget,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(filtersItems.length + 1, (index) {
            final i = index - 1;
            return Padding(
              padding: EdgeInsets.only(
                right:
                    isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8,
              ),
              child: ChipWidget(
                key: KWidgetkeys.widget.filterChip.chips,
                filter: i != -1
                    ? filtersItems.elementAt(i)
                    : (FilterItem(context.l10n.all)..number = fullLenght),
                onSelected: (isSelected) => onSelected(
                  i,
                ),
                isSelected: isSelected(
                      i,
                    ) ||
                    (i == -1 && filterIsEmpty),
                isDesk: isDesk,
              ),
            );
          }),
        ),
      );
}
