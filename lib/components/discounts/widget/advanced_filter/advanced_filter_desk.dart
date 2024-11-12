import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class AdvancedFilterDesk extends StatelessWidget {
  const AdvancedFilterDesk({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: KPadding.kPaddingSize32),
      child: Column(
        children: [
          // Row(
          //   children: [
          //     const IconWidget(
          //       icon: KIcon.tune,
          //       background: AppColors.materialThemeKeyColorsNeutral,
          //       padding: KPadding.kPaddingSize20,
          //     ),
          //     KSizedBox.kWidthSizedBox8,
          //     Expanded(
          //       child: Text(
          //         context.l10n.advancedFilter,
          //         style: AppTextStyle.materialThemeHeadlineSmall,
          //       ),
          //     ),
          //   ],
          // ),
          const AdvancedFilterButton(
            isDesk: true,
            // icon: showFilter
            //     ? KIcon.trailing.copyWith(
            //         key: KWidgetkeys
            //             .screen.discounts.advancedFilterButtonIcon,
            //       )
            //     : KIcon.trailingUp.copyWith(
            //         key: KWidgetkeys
            //             .screen.discounts.advancedFilterButtonIconUp,
            //       ),
          ),

          BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
            buildWhen: (previous, current) =>
                previous.loadingStatus != current.loadingStatus ||
                previous.filterLocation != current.filterLocation,
            builder: (context, state) {
              return Expanded(
                child: AdvancedFilterContent(
                  isDesk: true,
                  onChange: (value) => context
                      .read<DiscountWatcherBloc>()
                      .add(DiscountWatcherEvent.filterLocation(value)),
                  filterLocationes: state.filterLocation,
                  sorting: state.sorting,
                  onChangeSorting: (value) => context
                      .read<DiscountWatcherBloc>()
                      .add(DiscountWatcherEvent.sorting(value)),
                  chooseLocationList: state.choosenLocationList,
                  chooseSortingList: state.choosenSortingnList,
                ),
              );
            },
          ),
          // ...AdvanceFilter.resetButton(isDesk: true, context: context),
        ],
      ),
    );
  }
}
