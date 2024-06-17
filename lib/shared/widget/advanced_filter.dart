import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class AdvancedFilter extends StatelessWidget {
  const AdvancedFilter({
    required this.isDesk,
    required this.citiesList,
    required this.filterCitiesIndex,
    super.key,
  });
  final bool isDesk;
  final List<String> citiesList;
  final List<int> filterCitiesIndex;

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
            cities: citiesList,
            filterCitiesIndex: filterCitiesIndex,
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
    required List<String> cities,
    required List<int> filterCitiesIndex,
  }) =>
      [
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
        ...List.generate(
          filterCitiesIndex.length,
          (index) => Padding(
            padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
            child: TextButton.icon(
              style: KButtonStyles.filterButtonStyle,
              icon: KIcon.close,
              label: Text(cities.elementAt(filterCitiesIndex.elementAt(index))),
              onPressed: null,
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
          isCheck: true,
          text: context.l10n.fromLargestToSmallest,
          onChanged: null,
          isDesk: isDesk,
        ),
        KSizedBox.kHeightSizedBox16,
        CheckPointWidget(
          isCheck: true,
          text: context.l10n.free,
          onChanged: null,
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
              onChanged: null,
              isCheck: filterCitiesIndex.contains(index),
              text: cities.elementAt(index),
              isDesk: isDesk,
            ),
          ),
        ),
      ];
}
