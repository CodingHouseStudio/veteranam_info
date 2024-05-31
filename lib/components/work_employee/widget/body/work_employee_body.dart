import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class WorkEmployeeBody extends StatelessWidget {
  const WorkEmployeeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkEmployeeWatcherBloc, WorkEmployeeWatcherState>(
      builder: (context, _) => ScaffoldWidget(
        titleChildWidgetsFunction: ({required isDesk}) => [
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else
            KSizedBox.kHeightSizedBox24,
          ...TitleWidget.titleWidgetList(
            title: context.l10n.work,
            titleKey: KWidgetkeys.screen.workEmployee.title,
            subtitle: context.l10n.workSubtitle,
            subtitleKey: KWidgetkeys.screen.workEmployee.subtitle,
            isDesk: isDesk,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox24,
        ],
        mainDeskPadding:
            const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize220),
        mainChildWidgetsFunction: ({required isDesk}) {
          final childWidgets = [
            WorkEmployeeFilters(
              key: KWidgetkeys.screen.workEmployee.filter,
              cities: _.workModelItems.overallCities,
              categories: _.workModelItems.overallCategories,
              isDesk: isDesk,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox56
            else
              KSizedBox.kHeightSizedBox24,
          ];
          switch (_.loadingStatus) {
            case LoadingStatus.initial:
              childWidgets.add(const CircularProgressIndicator.adaptive());
            case LoadingStatus.loading:
              childWidgets.add(const CircularProgressIndicator.adaptive());
            case LoadingStatus.loaded:
              childWidgets.addAll([
                if (_.workModelItems.isNotEmpty)
                  ...List.generate(_.filteredWorkModelItems.length, (index) {
                    return Padding(
                      padding: index != 0
                          ? EdgeInsets.only(
                              top: isDesk
                                  ? KPadding.kPaddingSize56
                                  : KPadding.kPaddingSize24,
                            )
                          : EdgeInsets.zero,
                      child: WorkCardWidget(
                        key: KWidgetkeys.screen.workEmployee.cards,
                        firstItemIsFirst: index == 0,
                        workModel: _.filteredWorkModelItems.elementAt(index),
                        isDesk: isDesk,
                      ),
                    );
                  })
                else
                  TextButton(
                    key: KWidgetkeys.screen.workEmployee.mockDataButton,
                    onPressed: () {
                      GetIt.I.get<IWorkRepository>().addMockWorks();
                      context
                          .read<WorkEmployeeWatcherBloc>()
                          .add(const WorkEmployeeWatcherEvent.started());
                    },
                    child: Text(
                      context.l10n.getMockData,
                      style: AppTextStyle.text32,
                    ),
                  ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox24,
                WorkRequestCardWidget(
                  key: KWidgetkeys.screen.workEmployee.requestCard,
                  isDesk: isDesk,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox24,
                Center(
                  child: PaginationWidget(
                    key: KWidgetkeys.screen.workEmployee.pagination,
                    currentPage: _.page,
                    pages: _.maxPage,
                    changePage: (int page) {
                      context.read<WorkEmployeeWatcherBloc>().add(
                            WorkEmployeeWatcherEvent.loadPage(
                              page,
                            ),
                          );
                    },
                  ),
                ),
              ]);
            case LoadingStatus.error:
              childWidgets.add(const CircularProgressIndicator.adaptive());
          }
          return childWidgets
            ..add(
              isDesk
                  ? KSizedBox.kHeightSizedBox56
                  : KSizedBox.kHeightSizedBox24,
            );
        },
      ),
    );
  }
}
