import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/components/components.dart';
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
          final bloc = context.read<DiscountWatcherBloc>();
          await showModalBottomSheet<BlocProvider>(
            context: context,
            builder: (context) => BlocProvider.value(
              value: bloc,
              child: BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
                builder: (context, state) {
                  final body = widgetList(
                    isDesk: isDesk,
                    context: context,
                  );
                  return ListView.builder(
                    itemBuilder: (context, index) => body.elementAt(index),
                    itemCount: body.length,
                  );
                },
              ),
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
    final filterLocationIndex =
        context.read<DiscountWatcherBloc>().state.filtersLocationIndex;
    final location = context
        .read<DiscountWatcherBloc>()
        .state
        .discountModelItems
        .getLocationFilter(context);
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
      if (filterLocationIndex != null)
        ...List.generate(
          filterLocationIndex.length,
          (index) => Padding(
            padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                style: KButtonStyles.filterButtonStyle,
                icon: KIcon.close,
                label: Text(
                  location.elementAt(filterLocationIndex.elementAt(index)),
                ),
                onPressed: () => _onChange(
                  context: context,
                  index: filterLocationIndex.elementAt(index),
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
      ...List.generate(
        2,
        (index) => Padding(
          padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
          child: CheckPointWidget(
            onChanged: () => _onChange(context: context, index: index),
            isCheck: _isCheck(
              index: index,
              filterLocationIndex: filterLocationIndex,
            ),
            text: location.elementAt(index),
            isDesk: isDesk,
          ),
        ),
      ),
      KSizedBox.kHeightSizedBox24,
      Text(
        context.l10n.city,
        style: AppTextStyle.materialThemeTitleLarge,
      ),
      ...List.generate(
        location.length - 2,
        (index) {
          final i = index + 2;
          return Padding(
            padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
            child: CheckPointWidget(
              onChanged: () => _onChange(context: context, index: i),
              isCheck:
                  _isCheck(index: i, filterLocationIndex: filterLocationIndex),
              text: location.elementAt(i),
              isDesk: isDesk,
            ),
          );
        },
      ),
    ];
  }

  static bool _isCheck({
    required int index,
    required List<int>? filterLocationIndex,
  }) =>
      filterLocationIndex != null && filterLocationIndex.contains(index);

  static void _onChange({required int index, required BuildContext context}) =>
      context
          .read<DiscountWatcherBloc>()
          .add(DiscountWatcherEvent.filterLocation(index));
}
