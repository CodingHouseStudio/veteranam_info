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
        PopupMenuButton<String>(
          icon: const Icon(Icons.filter_alt_outlined),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: context.l10n.resetAllFilter,
                child: ListTile(
                  title: Text(context.l10n.resetAllFilter),
                ),
              ),
            ];
          },
          onSelected: (dynamic selectedValue) {
            if (selectedValue == context.l10n.resetAllFilter) {
              context.read<InformationWatcherBloc>().add(
                    const InformationWatcherEvent.filterReset(),
                  );
            }
          },
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
                                isSelected ? filter : null,
                              ),
                            ),
                    isSelected:
                        context.read<InformationWatcherBloc>().state.filter ==
                            filter,
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
