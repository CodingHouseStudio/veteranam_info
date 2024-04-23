import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class AuditInspectionInProgresFilters extends StatelessWidget {
  const AuditInspectionInProgresFilters({
    required this.filtersItem,
    required this.isDesk,
    super.key,
  });

  final List<String> filtersItem;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilterPopupMenuWidget(
          onResetValue: () => context.read<InformationWatcherBloc>().add(
                const InformationWatcherEvent.filterReset(),
              ),
        ),
        KSizedBox.kWidthSizedBox24,
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filtersItem.map((filter) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: isDesk
                        ? KPadding.kPaddingSize16
                        : KPadding.kPaddingSize8,
                  ),
                  child: ChipWidget(
                    filter: filter,
                    onSelected: ({required isSelected}) =>
                        context.read<InformationWatcherBloc>().add(
                              InformationWatcherEvent.filter(
                                filter: filter,
                                isSelected: isSelected,
                              ),
                            ),
                    isSelected: context
                            .read<InformationWatcherBloc>()
                            .state
                            .filters
                            ?.contains(filter) ??
                        false,
                    isDesk: isDesk,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
