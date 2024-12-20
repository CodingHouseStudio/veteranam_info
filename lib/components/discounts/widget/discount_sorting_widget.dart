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
          buttonStyle: KButtonStyles.transparentButtonStyle.copyWith(
            padding: const WidgetStatePropertyAll(
              EdgeInsets.all(KPadding.kPaddingSize12),
            ),
            backgroundColor: isDesk
                ? null
                : const WidgetStatePropertyAll(
                    AppColors.materialThemeKeyColorsNeutral,
                  ),
          ),
          buttonText: state.sortingBy.getValue(context),
          iconAlignment: IconAlignment.end,
          items: List.generate(
            DiscountEnum.values.length,
            (index) => getDropDownItem(
              discountEnum: DiscountEnum.values.elementAt(index),
              currectDiscountEnum: state.sortingBy,
              context: context,
            ),
            growable: false,
          ),
          buttonChild: isDesk
              ? null
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        context.l10n.sort,
                        style: AppTextStyle.materialThemeTitleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    KSizedBox.kWidthSizedBox8,
                    KIcon.sort,
                  ],
                ),
          clipBehavior: Clip.hardEdge,
          initialValue: state.sortingBy,
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
