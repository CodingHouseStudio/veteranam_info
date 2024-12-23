import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/watcher/discounts_watcher_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountSortingWidget extends StatelessWidget {
  const DiscountSortingWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountsWatcherBloc, DiscountsWatcherState>(
      buildWhen: (previous, current) => previous.sortingBy != current.sortingBy,
      builder: (context, state) {
        return PopupMenuButtonWidget<DiscountEnum>(
          buttonStyle: KButtonStyles.neutralButtonStyle,
          shape: const OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.materialThemeKeyColorsNeutral),
            borderRadius: KBorderRadius.kBorderRadiusExceptTopRight,
          ),
          buttonText: '',
          iconAlignment: IconAlignment.end,
          items: List.generate(
            DiscountEnum.values.length,
            (index) => getDropDownItem(
              discountEnum: DiscountEnum.values.elementAt(index),
              currectDiscountEnum: state.sortingBy ?? DiscountEnum.featured,
              context: context,
            ),
            growable: false,
          ),
          buttonChild:
              // isDesk
              //     ? null
              //     :
              Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              KIcon.sort,
              KSizedBox.kWidthSizedBox8,
              Flexible(
                child: Text(
                  state.sortingBy?.getValue(context) ?? context.l10n.sort,
                  style: AppTextStyle.materialThemeTitleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          initialValue: state.sortingBy ?? DiscountEnum.featured,
          position: PopupMenuButtonPosition.bottomLeft,
          showIcon: KIcon.arrowDropDown,
          closeIcon: KIcon.arrowDropUp,
        );
      },
    );
  }

  DropDownItem<DiscountEnum> getDropDownItem({
    required DiscountEnum discountEnum,
    required DiscountEnum currectDiscountEnum,
    required BuildContext context,
  }) =>
      DropDownItem<DiscountEnum>(
        value: discountEnum,
        text: discountEnum.getValue(context),
        event: () => context.read<DiscountsWatcherBloc>().add(
              DiscountsWatcherEvent.sorting(
                discountEnum,
              ),
            ),
        key: null,
      );
}
