import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FiltersChipWidget extends StatelessWidget {
  const FiltersChipWidget({
    required this.filtersItems,
    required this.isDesk,
    // required this.onResetValue,
    required this.onSelected,
    required this.isSelected,
    required this.fullLength,
    required this.filterIsEmpty,
    super.key,
  });

  final List<FilterItem> filtersItems;
  final int fullLength;
  final bool isDesk;
  final bool filterIsEmpty;
  // final void Function() onResetValue;
  final void Function(
    dynamic value,
  ) onSelected;
  final bool Function(
    dynamic value,
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

  Widget _body(BuildContext context) => VerticalScrollWidget(
        scrollKey: KWidgetkeys.widget.filterChip.widget,
        children: List.generate(filtersItems.length + 1, (index) {
          final i = index - 1;
          return Padding(
            padding: EdgeInsets.only(
              right: isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8,
            ),
            child: ChipWidget(
              key: KWidgetkeys.widget.filterChip.chips,
              filter: i != -1
                  ? filtersItems.elementAt(i)
                  : (FilterItem(
                      CategoryEnum.all.getValue(context),
                      number: fullLength,
                    )),
              onSelected: (isSelected) => onSelected(
                i != -1 ? filtersItems.elementAt(i).value : CategoryEnum.all,
              ),
              isSelected: isSelected(
                    i != -1
                        ? filtersItems.elementAt(i).value
                        : CategoryEnum.all,
                  ) ||
                  (i == -1 && filterIsEmpty),
              isDesk: isDesk,
            ),
          );
        }),
      );
}
