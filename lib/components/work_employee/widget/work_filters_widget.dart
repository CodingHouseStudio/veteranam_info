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
                  filters: cities,
                  onSelected: (newValue) =>
                      context.read<WorkEmployeeWatcherBloc>().add(
                            WorkEmployeeWatcherEvent.filterCities(
                              cities: newValue,
                            ),
                          ),
                  selectFilter:
                      context.read<WorkEmployeeWatcherBloc>().state.cities,
                  isDesk: isDesk,
                ),
                if (isDesk)
                  KSizedBox.kWidthSizedBox16
                else
                  KSizedBox.kWidthSizedBox8,
                DropChipWidget(
                  filters: categories,
                  onSelected: (newValue) =>
                      context.read<WorkEmployeeWatcherBloc>().add(
                            WorkEmployeeWatcherEvent.filterCategories(
                              categories: newValue,
                            ),
                          ),
                  selectFilter:
                      context.read<WorkEmployeeWatcherBloc>().state.categories,
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
