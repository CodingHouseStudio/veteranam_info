import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/components/discounts/bloc/discount_watcher_bloc.dart';
import 'package:kozak/shared/shared.dart';

class AdvancedFilter extends StatelessWidget {
  const AdvancedFilter({
    required this.isDesk,
    super.key,
  });
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        style: KButtonStyles.advancedFilterButtonStyle,
        label: Text(
          context.l10n.advancedFilter,
          style: isDesk
              ? AppTextStyle.materialThemeHeadlineSmall
              : AppTextStyle.materialThemeTitleMedium,
        ),
        // KSizedBox.kWidthSizedBox8,
        icon: IconWidget(
          icon: KIcon.tune,
          background: AppColors.materialThemeKeyColorsNeutral,
          padding: isDesk ? KPadding.kPaddingSize20 : KPadding.kPaddingSize12,
        ),
        onPressed: () async {
          final body = widgetList(
            isDesk: isDesk,
            context: context,
          );
          await showModalBottomSheet<ListView>(
            context: context,
            builder: (context) => ListView.builder(
              itemBuilder: (context, index) => body.elementAt(index),
              itemCount: body.length,
            ),
          );
        },
        //if (isDesk) KIcon.meil,
      ),
    );
  }

  static List<Widget> widgetList({
    required bool isDesk,
    required BuildContext context,
  }) {
    final filterCitiesIndex =
        context.read<DiscountWatcherBloc>().state.filtersCitiesIndex;
    final cities = context
        .read<DiscountWatcherBloc>()
        .state
        .discountModelItems
        .overallItem(
          getFilter: (item) => [
            if (item.location != null) ...item.location!,
            if (item.subLocation != null) item.subLocation.toString(),
          ],
          context: context,
        );
    return [
      Row(
        children: [
          const IconWidget(
            icon: KIcon.close,
            background: AppColors.materialThemeWhite,
            padding: KPadding.kPaddingSize12,
          ),
          KSizedBox.kWidthSizedBox8,
          Text(
            context.l10n.advancedFilter,
            style: AppTextStyle.materialThemeTitleMedium,
          ),
        ],
      ),
      KSizedBox.kHeightSizedBox24,
      Text(
        context.l10n.filterApplied,
        style: isDesk
            ? AppTextStyle.materialThemeTitleLarge
            : AppTextStyle.materialThemeTitleMedium,
      ),
      if (filterCitiesIndex != null)
        ...List.generate(
          filterCitiesIndex.length,
          (index) => Padding(
            padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                style: KButtonStyles.filterButtonStyle,
                icon: KIcon.close,
                label:
                    Text(cities.elementAt(filterCitiesIndex.elementAt(index))),
                onPressed: () => context.read<DiscountWatcherBloc>().add(
                      DiscountWatcherEvent.filterCity(
                        filterCitiesIndex.elementAt(index),
                      ),
                    ),
              ),
            ),
          ),
        ),
      KSizedBox.kHeightSizedBox24,
      Text(
        context.l10n.discount,
        style: AppTextStyle.materialThemeTitleMedium,
      ),
      KSizedBox.kHeightSizedBox16,
      CheckPointWidget(
        isCheck: context.read<DiscountWatcherBloc>().state.reverse,
        text: context.l10n.fromLargestToSmallest,
        onChanged: () => context.read<DiscountWatcherBloc>().add(
              const DiscountWatcherEvent.reverseFilter(),
            ),
        isDesk: isDesk,
      ),
      KSizedBox.kHeightSizedBox16,
      CheckPointWidget(
        isCheck: context.read<DiscountWatcherBloc>().state.freeFilter,
        text: context.l10n.free,
        onChanged: () => context
            .read<DiscountWatcherBloc>()
            .add(const DiscountWatcherEvent.isFreeFilter()),
        isDesk: isDesk,
      ),
      KSizedBox.kHeightSizedBox24,
      Text(
        context.l10n.city,
        style: AppTextStyle.materialThemeTitleLarge,
      ),
      ...List.generate(
        cities.length,
        (index) => Padding(
          padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
          child: CheckPointWidget(
            onChanged: () => context
                .read<DiscountWatcherBloc>()
                .add(DiscountWatcherEvent.filterCity(index)),
            isCheck:
                filterCitiesIndex != null && filterCitiesIndex.contains(index),
            text: cities.elementAt(index),
            isDesk: isDesk,
          ),
        ),
      ),
    ];
  }
}
