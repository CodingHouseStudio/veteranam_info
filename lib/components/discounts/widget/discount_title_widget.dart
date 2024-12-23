import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
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
          rightWidget: isDesk
              ? BlocBuilder<ViewModeCubit, ViewMode>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        const DiscountSortingWidget(isDesk: true),
                        KSizedBox.kWidthSizedBox16,
                        IconButtonWidget(
                          icon: KIcon.gridView,
                          onPressed: () =>
                              context.read<ViewModeCubit>().setGridView(),
                          padding: KPadding.kPaddingSize12,
                          buttonStyle: state == ViewMode.grid
                              ? KButtonStyles.circularBorderNeutralButtonStyle
                              : KButtonStyles
                                  .circularBorderTransparentButtonStyle,
                        ),
                        KSizedBox.kWidthSizedBox16,
                        IconButtonWidget(
                          icon: KIcon.viewAgenda,
                          onPressed: () =>
                              context.read<ViewModeCubit>().setListView(),
                          padding: KPadding.kPaddingSize12,
                          buttonStyle: state == ViewMode.list
                              ? KButtonStyles.circularBorderNeutralButtonStyle
                              : KButtonStyles
                                  .circularBorderTransparentButtonStyle,
                        ),
                      ],
                    );
                  },
                )
              : null,
          titleKey: KWidgetkeys.screen.discounts.title,
          isDesk: isDesk,
          preDividerWidget: isDesk
              ? null
              : DiscountsFilterMob(
                  key: KWidgetkeys.screen.discounts.advancedFilterMob,
                ),
        ),
      ),
    );
  }
}
