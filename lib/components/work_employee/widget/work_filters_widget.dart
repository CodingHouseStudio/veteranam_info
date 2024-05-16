import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

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
        ),
        KSizedBox.kWidthSizedBox24,
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                DropChipWidget(
                  key: KWidgetkeys.screen.workEmployee.citiesFilter,
                  filters: cities..add(context.l10n.city),
                  onSelected: (newValue) =>
                      context.read<WorkEmployeeWatcherBloc>().add(
                            WorkEmployeeWatcherEvent.filterCities(
                              city: newValue,
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
                  key: KWidgetkeys.screen.workEmployee.categoriesFilter,
                  filters: categories..add(context.l10n.category),
                  onSelected: (newValue) =>
                      context.read<WorkEmployeeWatcherBloc>().add(
                            WorkEmployeeWatcherEvent.filterCategories(
                              category: newValue,
                            ),
                          ),
                  selectFilter:
                      context.read<WorkEmployeeWatcherBloc>().state.category ??
                          context.l10n.category,
                  isDesk: isDesk,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
