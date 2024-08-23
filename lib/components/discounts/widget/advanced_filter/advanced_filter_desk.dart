import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class AdvancedFilterDesk extends StatefulWidget {
  const AdvancedFilterDesk({super.key});

  @override
  State<AdvancedFilterDesk> createState() => _AdvancedFilterDeskState();
}

class _AdvancedFilterDeskState extends State<AdvancedFilterDesk> {
  late bool showFilter = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
      builder: (context, state) {
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
              AdvancedFilterButton(
                onPressed: () => setState(() {
                  showFilter = !showFilter;
                }),
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

              if (showFilter)
                Expanded(
                  child: AdvancedFilterContent(
                    isDesk: true,
                    onChange: (value) => context
                        .read<DiscountWatcherBloc>()
                        .add(DiscountWatcherEvent.filterLocation(value)),
                    filterLocationes: context
                        .read<DiscountWatcherBloc>()
                        .state
                        .filtersLocation,
                    sorting: context.read<DiscountWatcherBloc>().state.sorting,
                    onChangeSorting: (value) => context
                        .read<DiscountWatcherBloc>()
                        .add(DiscountWatcherEvent.sorting(value)),
                  ),
                ),
              // ...AdvanceFilter.resetButton(isDesk: true, context: context),
            ],
          ),
        );
      },
    );
  }
}
