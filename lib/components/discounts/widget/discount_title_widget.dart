import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/watcher/discount_watcher_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountTitleWidget extends StatelessWidget {
  const DiscountTitleWidget({
    required this.isDesk,
    super.key,
  });
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: KPadding.kPaddingSize24),
        child: LineTitleIconWidget(
          title: context.l10n.discounts,
          rightWidget: BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
            buildWhen: (previous, current) =>
                previous.sortingBy != current.sortingBy,
            builder: (context, state) {
              return PopupMenuButtonWidget<DiscountEnum>(
                buttonStyle: KButtonStyles.transparentButtonStyle,
                buttonText: state.sortingBy.getValue(context),
                items: List.generate(
                  DiscountEnum.values.length,
                  (index) => getDropDownItem(
                    discountEnum: DiscountEnum.values.elementAt(index),
                    currectDiscountEnum: state.sortingBy,
                    context: context,
                  ),
                  growable: false,
                ),
                clipBehavior: Clip.hardEdge,
                initialValue: state.sortingBy,
                position: PopupMenuButtonPosition.bottomLeft,
              );
            },
          ),
          titleKey: KWidgetkeys.screen.discounts.title,
        ),
      ),
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
        event: () => context.read<DiscountWatcherBloc>().add(
              DiscountWatcherEvent.sorting(
                discountEnum,
              ),
            ),
        key: null,
      );
}
