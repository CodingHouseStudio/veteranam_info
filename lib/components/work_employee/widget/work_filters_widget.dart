import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class WorkEmployeeFilters extends StatelessWidget {
  const WorkEmployeeFilters({
    required this.categories,
    required this.isDesk,
    required this.cities,
    super.key,
  });

  final List<String> categories;
  final List<String> cities;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilterPopupMenuWidget(
          key: KWidgetkeys.screen.workEmployee.resetFilter,
          onResetValue: () => context.read<WorkEmployeeWatcherBloc>().add(
                const WorkEmployeeWatcherEvent.filterReset(),
              ),
          isDesk: isDesk,
        ),
        KSizedBox.kWidthSizedBox24,
        Expanded(
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  DropChipWidget(
                    widgetKey: KWidgetkeys.screen.workEmployee.citiesFilter,
                    buttonKey:
                        KWidgetkeys.screen.workEmployee.citiesFilterbuttons,
                    filters: [...cities, context.l10n.city],
                    onSelected: (newValue) =>
                        context.read<WorkEmployeeWatcherBloc>().add(
                              WorkEmployeeWatcherEvent.filterCities(
                                city: newValue != context.l10n.city
                                    ? newValue
                                    : null,
                              ),
                            ),
                    selectFilter:
                        context.read<WorkEmployeeWatcherBloc>().state.city ??
                            context.l10n.city,
                    isDesk: isDesk,
                  ),
                  if (isDesk)
                    KSizedBox.kWidthSizedBox16
                  else
                    KSizedBox.kWidthSizedBox8,
                  DropChipWidget(
                    widgetKey: KWidgetkeys.screen.workEmployee.categoriesFilter,
                    buttonKey:
                        KWidgetkeys.screen.workEmployee.categoriesFilterButtons,
                    filters: [...categories, context.l10n.category],
                    onSelected: (newValue) =>
                        context.read<WorkEmployeeWatcherBloc>().add(
                              WorkEmployeeWatcherEvent.filterCategories(
                                category: newValue != context.l10n.category
                                    ? newValue
                                    : null,
                              ),
                            ),
                    selectFilter: context
                            .read<WorkEmployeeWatcherBloc>()
                            .state
                            .category ??
                        context.l10n.category,
                    isDesk: isDesk,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
